import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/widgets/counts_widgets.dart';
import 'package:teacher/presentation/screens/courses/widgets/courses_list.dart';

import '../../../../domain/models/course.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';
import '../controller/courses_controller.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await Get.find<CoursesController>().getCourses(),
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            HomeAppBar(),
            const SizedBox(height: 8.0,),
            const CountsWidgets(),
            const SizedBox(height: 8.0,),
            GetX<CoursesController>(
              init: Get.find<CoursesController>(),
              builder: (CoursesController controller) {
                if (controller.status.isLoading) {
                  return const LoadingScreen();
                } else if (controller.status.isError) {
                  return ErrorScreen(error: controller.status.errorMessage ?? '');
                } else if (controller.courses.isEmpty){
                  return const EmptyScreen(emptyString: AppStrings.noCourses);
                }
                final List<Course> courses = controller.courses;
                return CoursesList(
                  courses: courses,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
