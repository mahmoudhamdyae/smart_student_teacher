import 'package:dio/dio.dart';
import 'package:teacher/domain/models/course.dart';

import '../../core/constants.dart';
import '../../domain/models/wehda.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  Future<dynamic> logIn(String phone, String password);
  Future<List<Course>> getCourses(int userId);
  Future<List<Wehda>> getTutorials(int courseId);
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
  Future<List<Course>> getCourses(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}courses";
    final response = await _dio.get(url);

    List<Course> courses = [];
    // String s = convertSaff(marhala, 'course');
    for (var singleCourse in response.data['coursesix']) {
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
}