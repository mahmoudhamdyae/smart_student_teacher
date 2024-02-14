import 'package:flutter/material.dart';
import 'package:teacher/core/utils/insets.dart';
import 'package:teacher/presentation/screens/courses/widgets/course_item.dart';

import '../../../../domain/models/course.dart';

class CoursesList extends StatelessWidget {

  final List<Course> courses;
  const CoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return isWide(context) ? _buildGridView(context) : _buildListView();
  }

  ListView _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        return CourseItem(course: courses[index]);
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      crossAxisCount:(MediaQuery.of(context).size.width ~/ 350).toInt(),
      childAspectRatio: 2.2,
      children: List.generate(courses.length, (index) {
        return CourseItem(course: courses[index]);
      }),
    );
  }
}
