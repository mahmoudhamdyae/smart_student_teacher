import 'package:teacher/domain/models/book.dart';
import 'package:teacher/domain/models/course.dart';
import 'package:teacher/domain/models/notification.dart';
import 'package:teacher/domain/models/teacher_exam_model.dart';

import '../models/wehda.dart';

abstract class Repository {
  // Local Data Source
  Future<bool> isFirstTime();
  bool isUserLoggedIn();
  String getUserName();

  // Account Service
  Future<void> logIn(String phone, String password);
  Future<void> signOut();

  // Remote Data Source
  Future<CoursesResponse> getCourses();
  Future<BooksResponse> getBooks();
  Future<List<Wehda>> getTutorials(int courseId);
  Future<List<NotificationModel>> getNotifications();
  Future<void> addComment(String comment, int videoId);
  Future<TeacherExamModel> getTeacherExams();
  Future<void> delNotification(int notificationId);
}