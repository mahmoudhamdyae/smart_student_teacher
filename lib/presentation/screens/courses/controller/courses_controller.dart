import 'package:get/get.dart';
import 'package:teacher/core/constants.dart';
import 'package:teacher/domain/models/wehda.dart';
import 'package:teacher/presentation/resources/assets_manager.dart';

import '../../../../domain/models/course.dart';
import '../../../../domain/models/lesson.dart';
import '../../../../domain/repository/repository.dart';

class CoursesController extends GetxController {

  final RxList<Course> courses = RxList.empty();
  final RxList<Wehda> tutorials = RxList.empty();
  final Rx<Course> course = Course().obs;
  final RxInt usersCount = 0.obs;
  final RxDouble totalEarn = 0.0.obs;
  final RxString teacherImage = ImageAssets.user.obs;
  final RxList<Comments> comments = RxList.empty();
  final Rx<Lesson> _selectedLesson = Lesson().obs;
  set selectedLesson(Rx<Lesson> value) {
    _selectedLesson.value = value.value;
  }
  Rx<Lesson> get selectedLesson {
    return _selectedLesson;
  }

  final Rx<RxStatus> _getCommentsStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get getCommentsStatus => _getCommentsStatus.value;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  CoursesController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getCourses();
  }

  Future<void> getCourses() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.getCourses().then((remoteCoursesResponse) {
        _status.value = RxStatus.success();
        courses.value = remoteCoursesResponse.courses ?? [];
        teacherImage.value = remoteCoursesResponse.teacher?.image == null ? ImageAssets.user : '${Constants.siteUrl}${remoteCoursesResponse.teacher?.image}';
        totalEarn.value = remoteCoursesResponse.totalEarn ?? 0;
        _getUsersCount();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void getTutorials() {
    _status.value = RxStatus.loading();
    try {
      _repository.getTutorials(course.value.id ?? -1).then((remoteTutorials) {
        _status.value = RxStatus.success();
        tutorials.value = remoteTutorials;
        _selectedLesson.value = remoteTutorials[0].lessons[0];
        comments.value = _selectedLesson.value.comments ?? [];
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void _getUsersCount() {
    usersCount.value = 0;
    for (var singleCourse in courses) {
      usersCount.value += singleCourse.userCount ?? 0;
    }
  }
}