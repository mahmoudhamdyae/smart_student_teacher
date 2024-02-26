import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/widgets/home_app_bar/home_app_bar.dart';

import '../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/loading_screen.dart';
import '../controller/exams_controller.dart';
import '../widgets/exams_course_list.dart';

class ExamsCoursesScreen extends StatelessWidget {
  const ExamsCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          RefreshIndicator(
            onRefresh: () => Get.find<ExamsController>().getTeacherExams(),
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                GetX<ExamsController>(
                  init: Get.find<ExamsController>(),
                  builder: (ExamsController controller) {
                    if (controller.status.isLoading) {
                      return const LoadingScreen();
                    } else if (controller.status.isError) {
                      return ErrorScreen(error: controller.status.errorMessage ?? '');
                    } else if (controller.courses.isEmpty) {
                      return const EmptyScreen(emptyString: AppStrings.noExamCourses);
                    } else {
                      final courses = controller.courses;
                      return ExamsCourseList(
                        subjects: courses.toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
