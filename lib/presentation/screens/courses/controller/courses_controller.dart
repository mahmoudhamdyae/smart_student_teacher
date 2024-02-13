import 'package:get/get.dart';
import 'package:teacher/domain/models/wehda.dart';

import '../../../../domain/models/course.dart';
import '../../../../domain/repository/repository.dart';

class CoursesController extends GetxController {

  final RxList<Course> courses = RxList.empty();
  final RxList<Wehda> tutorials = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  CoursesController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getCourses();
  }

  void _getCourses() {
    _status.value = RxStatus.loading();
    try {
      _repository.getCourses().then((remoteCourses) {
        _status.value = RxStatus.success();
        courses.value = remoteCourses;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void getTutorials(int courseId) {
    _status.value = RxStatus.loading();
    try {
      _repository.getTutorials(courseId).then((remoteTutorials) {
        _status.value = RxStatus.success();
        tutorials.value = remoteTutorials;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}