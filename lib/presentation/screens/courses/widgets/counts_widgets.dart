import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class CountsWidgets extends StatelessWidget {
  const CountsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    AppStrings.total,
                    style: getLargeStyle(),
                    textAlign: TextAlign.center,
                  ),
                  GetX<CoursesController>(
                    init: Get.find<CoursesController>(),
                    builder: (CoursesController controller) {
                      return Text(
                        '${controller.totalEarn} د.ك',
                        style: getSmallStyle(),
                        textAlign: TextAlign.center,
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    AppStrings.noSub,
                    style: getLargeStyle(),
                    textAlign: TextAlign.center,
                  ),
                  GetX<CoursesController>(
                    init: Get.find<CoursesController>(),
                    builder: (CoursesController controller) {
                      return Text(
                        controller.usersCount.value.toString(),
                        style: getSmallStyle(),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: VerticalDivider(width: 2, color: ColorManager.lightGrey,)
        ),
      ],
    );
  }
}
