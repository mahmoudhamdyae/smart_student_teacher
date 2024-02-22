import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/course.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../screens/course_screen.dart';

class CourseItem extends StatelessWidget {

  final Course course;
  const CourseItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CourseScreen(course: course,));
      },
      child: Container(
        height: 90,
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
              top: -32,
              right: -2,
              child: Image.asset(
                ImageAssets.course,
                height: 140,
                width: 110,
              ),
            ),
            Positioned(
              right: 125.0,
              top: 12.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name ?? '',
                    style: getLargeStyle(
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  Text(
                    'عدد المشتركين: ${course.userCount}',
                    style: getSmallStyle(
                      color: ColorManager.grey,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12.0,
              left: 8.0,
              child: Text(
                course.marhala ?? '',
                style: getSmallStyle(
                  color: const Color(0xff808080),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
