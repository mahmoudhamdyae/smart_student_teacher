import 'package:get/get.dart';
import 'package:teacher/domain/models/teacher_exam_model.dart';

import '../../../../domain/repository/repository.dart';

class ExamsController extends GetxController {

  final RxSet<TeacherCourse> courses = RxSet();
  final Rx<TeacherExamModel> teacherExams = TeacherExamModel().obs;
  final Rx<TeacherExam> exams = TeacherExam().obs;
  final Rx<TeacherBank> banks = TeacherBank().obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  ExamsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getTeacherExams();
  }

  Future<void> getTeacherExams() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.getTeacherExams().then((teacherExamModel) {
        _status.value = RxStatus.success();
        teacherExams.value = teacherExamModel;
        courses.clear();
        teacherExamModel.teacherExam?.forEach((singleExam) {
          bool isInCourses = false;
          for (var singleCourse in courses) {
            if (singleCourse.id == singleExam.course?.id) {
              isInCourses = true;
              break;
            }
          }
          if (!isInCourses) {
            courses.add(singleExam.course!);
          }
        });
        teacherExamModel.teacherBank?.forEach((singleBank) {
          bool isInCourses = false;
          for (var singleCourse in courses) {
            if (singleCourse.id == singleBank.course?.id) {
              isInCourses = true;
              break;
            }
          }
          if (!isInCourses) {
            courses.add(singleBank.course!);
          }
        });
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  TeacherExam? getCourseExams(int courseId) {
    TeacherExam? teacherExam;
    teacherExams.value.teacherExam?.forEach((singleExam) {
      if (singleExam.course?.id == courseId) {
        teacherExam = singleExam;
      }
    });
    return teacherExam;
  }

  TeacherBank? getCourseBanks(int courseId) {
    TeacherBank? teacherBank;
    teacherExams.value.teacherBank?.forEach((singleBank) {
      if (singleBank.course?.id == courseId) {
        teacherBank = singleBank;
      }
    });
    return teacherBank;
  }
}