import 'package:teacher/domain/models/course.dart';
import 'package:teacher/domain/models/notification.dart';

import 'package:teacher/domain/models/wehda.dart';

import '../../domain/models/book.dart';
import '../../domain/models/teacher_exam_model.dart';
import '../../domain/repository/repository.dart';
import '../local/local_data_source.dart';
import '../remote/remote_data_source.dart';

class RepositoryImpl extends Repository {

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._remoteDataSource, this._localDataSource);

  // Local Data Source

  @override
  Future<bool> isFirstTime() {
    return _localDataSource.isFirstTime();
  }

  @override
  bool isUserLoggedIn() {
    return _localDataSource.isUserLoggedIn();
  }

  @override
  String getUserName() {
    return _localDataSource.getUserName();
  }

  // Account Service

  @override
  Future<void> logIn(String phone, String password) {
    return _remoteDataSource.logIn(phone, password).then((data) {
      _localDataSource.setUserId(data['user']['id']);
      _localDataSource.setUserName(data['user']['name']);
      _localDataSource.setUserLoggedIn();
      _remoteDataSource.sendTokenAndUserId(_localDataSource.getUserId());
    });
  }

  @override
  Future<void> signOut() async {
    _remoteDataSource.getFcmToken();
    return await _localDataSource.signOut();
  }

  // Remote Data Source

  @override
  Future<CoursesResponse> getCourses() async {
    return await _remoteDataSource.getCourses(_localDataSource.getUserId());
  }

  @override
  Future<BooksResponse> getBooks() {
    return _remoteDataSource.getBooks(_localDataSource.getUserId());
  }

  @override
  Future<List<Wehda>> getTutorials(int courseId) {
    return _remoteDataSource.getTutorials(courseId);
  }

  @override
  Future<List<NotificationModel>> getNotifications() {
    return _remoteDataSource.getNotifications(_localDataSource.getUserId());
  }

  @override
  Future<void> addComment(String comment, int videoId) async {
    return await _remoteDataSource.addComment(comment, _localDataSource.getUserId(), videoId);
  }

  @override
  Future<TeacherExamModel> getTeacherExams() async {
    return await _remoteDataSource.getTeacherExams(_localDataSource.getUserId());
  }

  @override
  Future<void> delNotification(int notificationId) async {
    await _remoteDataSource.delNotification(notificationId);
  }
}