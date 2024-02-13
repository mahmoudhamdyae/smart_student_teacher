import 'package:teacher/domain/models/course.dart';

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
  Future<List<Course>> getCourses();
  Future<List<Wehda>> getTutorials(int courseId);
}