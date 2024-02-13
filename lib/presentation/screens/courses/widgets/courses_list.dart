import 'package:flutter/material.dart';
import 'package:teacher/presentation/screens/courses/widgets/course_item.dart';

import '../../../../domain/models/course.dart';

class CoursesList extends StatelessWidget {

  final List<Course> courses;
  const CoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        return CourseItem(course: courses[index]);
      },
    );
  }
}
