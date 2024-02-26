import 'package:flutter/material.dart';
import 'package:teacher/domain/models/teacher_exam_model.dart';

import '../../../../core/utils/insets.dart';
import 'exam_course_item.dart';

class ExamsCourseList extends StatelessWidget {

  final List<TeacherCourse> subjects;
  const ExamsCourseList({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return isWide(context) ? _buildCoursesGrid(context) : _buildCoursesList();
  }

  ListView _buildCoursesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: subjects.length,
      itemBuilder: (BuildContext context, int index) {
        return ExamCourseItem(course: subjects[index],);
      },
    );
  }

  Widget _buildCoursesGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: (MediaQuery.of(context).size.width ~/ 300).toInt(),
      childAspectRatio: 1.8,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: List.generate(subjects.length, (index) {
        return ExamCourseItem(course: subjects[index],);
      }),
    );
  }
}
