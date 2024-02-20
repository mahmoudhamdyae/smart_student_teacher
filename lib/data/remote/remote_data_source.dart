import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:teacher/domain/models/comment.dart';
import 'package:teacher/domain/models/course.dart';

import '../../core/constants.dart';
import '../../domain/models/wehda.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  // Account Service
  Future<dynamic> logIn(String phone, String password);
  Future<String> getFcmToken();
  void sendTokenAndUserId(int userId);

  // Remote Data Source
  Future<List<Course>> getCourses(int userId);
  Future<List<Wehda>> getTutorials(int courseId);
  Future<List<Comment>> getComments(int userId);
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
  Future<List<Course>> getCourses(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}teacher/courses/$userId";
    final response = await _dio.get(url);

    List<Course> courses = [];
    for (var singleCourse in response.data['courses']) {
      Course course = Course.fromJson(singleCourse);
      courses.add(course);
    }

    return courses;
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
  Future<List<Comment>> getComments(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}video/getComment/$userId";
    final response = await _dio.get(url);

    CommentResponse commentResponse = CommentResponse.fromJson(response.data);
    return commentResponse.comments ?? [];
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