import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/domain/models/teacher_exam_model.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../controller/exams_controller.dart';
import '../screens/exams_and_banks_screen.dart';

class ExamCourseItem extends StatelessWidget {

  final TeacherCourse course;
  const ExamCourseItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<ExamsController>().getTeacherExams();
        Get.to(() => ExamsAndBanksScreen(course: course,));
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          border: Border.all(
            color: ColorManager.lightGrey,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -12,
              right: -2,
              child: Image.asset(
                ImageAssets.course,
                height: 75,
                width: 100,
              ),
            ),
            Positioned(
              right: 125.0,
              top: 16.0,
              child: Text(
                course.subjectName ?? '',
                style: getLargeStyle(
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: Text(
                course.classroom ?? '',
                style: getSmallStyle(
                    color: ColorManager.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
