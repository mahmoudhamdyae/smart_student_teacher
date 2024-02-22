import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teacher/domain/models/course.dart';

import '../../core/constants.dart';
import '../../domain/models/book.dart';
import '../../domain/models/notification.dart';
import '../../domain/models/wehda.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  // Account Service
  Future<dynamic> logIn(String phone, String password);
  Future<String> getFcmToken();
  void sendTokenAndUserId(int userId);

  // Remote Data Source
  Future<CoursesResponse> getCourses(int userId);
  Future<BooksResponse> getBooks(int userId);
  Future<List<Wehda>> getTutorials(int courseId);
  Future<List<NotificationModel>> getNotifications(int userId);
  Future<void> addComment(String comment, int userId, int videoId);
}

class RemoteDataSourceImpl extends RemoteDataSource {

  final NetworkInfo _networkInfo;
  final Dio _dio;
  RemoteDataSourceImpl(this._networkInfo, this._dio);

  _checkNetwork() async {
    if (!await _networkInfo.isConnected) {
      throw Exception(AppStrings.noInternetError);
    }
  }

  @override
  Future<dynamic> logIn(String phone, String password) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}auth/login?&password=$password&phone=$phone";
    final response = await _dio.post(url, data: {
      'password': password,
      'phone': phone,
    });

    final data = response.data;
    if (data["access_token"] == null) {
      throw Exception(AppStrings.wrongPhoneOrPassword);
    }
    if (data["user"]["user_type"] != 'teacher') {
      throw Exception(AppStrings.notTeacher);
    }
    return data;
  }

  @override
  Future<String> getFcmToken() async {
    String? token;
    await FirebaseMessaging.instance.deleteToken().then((value) async => token = await FirebaseMessaging.instance.getToken());
    return token ?? '';
  }

  @override
  void sendTokenAndUserId(int userId) async {
    getFcmToken().then((token) async {
      await _checkNetwork();
      String url = "${Constants.baseUrl}mandub/fcm-token?user_id=$userId&token=$token";
      await _dio.patch(url);
    });
  }

  @override
  Future<CoursesResponse> getCourses(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}teacher/courses/$userId";
    final response = await _dio.get(url);

    CoursesResponse coursesResponse = CoursesResponse.fromJson(response.data);
    return coursesResponse;
  }

  @override
  Future<BooksResponse> getBooks(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}teacher/books/$userId";
    final response = await _dio.get(url);

    BooksResponse booksResponse = BooksResponse.fromJson(response.data);
    return booksResponse;
  }

  @override
  Future<List<Wehda>> getTutorials(int courseId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}tutorial/$courseId";
    final response = await _dio.get(url);

    List<Wehda> wehdat = [];
    for (var singleCourse in response.data['tutorial']) {
      Wehda wehda = Wehda.fromJson(singleCourse);
      wehdat.add(wehda);
    }

    return wehdat;
  }

  @override
  Future<List<NotificationModel>> getNotifications(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}teacher/notify/$userId";
    final response = await _dio.get(url);

    List<NotificationModel> notifications = [];
    for (var singleNotification in response.data) {
      notifications.add(NotificationModel.fromJson(singleNotification));
    }
    return notifications;
  }

  @override
  Future<void> addComment(String comment, int userId, int videoId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}video/addComment";

    await _dio.post(
      url,
      data: jsonEncode({
        'video_id': videoId,
        'user_id': userId,
        'comment': comment,
      }),
    );
  }
}