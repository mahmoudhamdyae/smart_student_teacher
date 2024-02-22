import 'package:teacher/domain/models/course.dart';
import 'package:teacher/domain/models/notification.dart';

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
  Future<List<Wehda>> getTutorials(int courseId);
  Future<List<NotificationModel>> getNotifications();
  Future<void> addComment(String comment, int videoId);
}