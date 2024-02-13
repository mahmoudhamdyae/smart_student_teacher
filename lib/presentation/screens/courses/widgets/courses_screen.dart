import 'package:flutter/material.dart';
import 'package:teacher/presentation/screens/courses/widgets/courses_list.dart';

import '../../../widgets/home_app_bar/home_app_bar.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          const CoursesList(),
        ],),
    );
  }
}
