import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/domain/models/teacher_exam_model.dart';

import '../../../resources/strings_manager.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/top_bar.dart';
import '../controller/exams_controller.dart';
import '../widgets/exam_list.dart';

class ExamsAndBanksScreen extends StatelessWidget {

  final TeacherCourse course;
  const ExamsAndBanksScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title: AppStrings.examsAndBanks),
          GetX<ExamsController>(
            init: Get.find<ExamsController>(),
            builder: (ExamsController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else {
                TeacherExam? exam = controller.getCourseExams(course.id ?? -1);
                TeacherBank? banks = controller.getCourseBanks(course.id ?? -1);
                return ExamList(exams: exam, banks: banks,);
              }
            },
          ),
        ],
      ),
    );
  }
}
