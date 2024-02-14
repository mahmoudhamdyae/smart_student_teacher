import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/course.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../widgets/price_widget.dart';
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
        height: 120,
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
                height: 140,
                width: 110,
              ),
            ),
            Positioned(
              right: 125.0,
              top: 16.0,
              child: Column(
                children: [
                  Text(
                    course.name ?? '',
                    style: getLargeStyle(
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  PriceWidget(price: course.month ?? 0, month: AppStrings.monthly,),
                ],
              ),
            ),
            Positioned(
              top: 16.0,
              left: 50.0,
              child: Column(
                children: [
                  Text(
                    course.marhala ?? '',
                    style: getSmallStyle(
                      color: const Color(0xff808080),
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  PriceWidget(price: course.term ?? 0, month: AppStrings.termly,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
