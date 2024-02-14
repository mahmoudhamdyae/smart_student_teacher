import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';

import '../../../../domain/models/course.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../widgets/price_widget.dart';
import 'lesson_screen.dart';

class CourseScreen extends StatelessWidget {

  final Course course;
  const CourseScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  ImageAssets.course,
                  height: 240,
                ),
                // Subject Name
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.name ?? '',
                        style: getLargeStyle(),
                      ),
                      // 5 وحدات - 32 درس
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '5 وحدات - 32 درس',
                          style: getSmallStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PriceWidget(price: course.month ?? 0, month: AppStrings.monthly,),
                        PriceWidget(price: course.term ?? 0, month: AppStrings.termly,),
                      ],
                    ),
                    const Positioned(
                        right: 0,
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: VerticalDivider(width: 1, color: ColorManager.lightGrey,)
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Divider(height: 1, color: Color(0xffF2F2F2),),
                ),
                // المدرس
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppStrings.courseTeacher,
                    style: getLargeStyle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        ImageAssets.user,
                        height: 40,
                        width: 40,
                      ),
                      // Teacher Name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          course.teacher ?? '',
                          style: getSmallStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64.0,),
              ],
            ),
          ),
          // Back Button
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.black,
                ),
              )
          ),
          // شاهد الدروس
          Positioned(
            bottom: 8.0,
            right: 16.0,
            left: 16.0,
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: getFilledButtonStyle(),
                onPressed: () {
                  CoursesController controller = Get.find<CoursesController>();
                  controller.course.value = course;
                  controller.getTutorials();
                  Get.to(() => const LessonScreen());
                },
                child: Text(
                  AppStrings.watchFirstLesson,
                  style: getSmallStyle(
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
