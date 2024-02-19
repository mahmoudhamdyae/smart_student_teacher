import 'package:get/get.dart';
import 'package:teacher/domain/models/wehda.dart';

import '../../../../domain/models/course.dart';
import '../../../../domain/models/lesson.dart';
import '../../../../domain/repository/repository.dart';

class CoursesController extends GetxController {

  final RxList<Course> courses = RxList.empty();
  final RxList<Wehda> tutorials = RxList.empty();
  final Rx<Course> course = Course().obs;
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
      await _repository.getCourses().then((remoteCourses) {
        _status.value = RxStatus.success();
        courses.value = remoteCourses;
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
}