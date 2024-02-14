import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';

import '../../auth/auth_controller.dart';
import 'lessons_widgets.dart';

class TabCourseLessons extends StatelessWidget {

  final bool isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
  TabCourseLessons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LessonsWidget(wehdat: Get.find<CoursesController>().tutorials,),
    );
  }
}
