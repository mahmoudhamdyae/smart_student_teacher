import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';

import '../../../../domain/models/course.dart';
import '../../../../domain/models/wehda.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../screens/lesson_screen.dart';

class LessonsWidget extends StatefulWidget {
  final List<Wehda> wehdat;

  const LessonsWidget({super.key, required this.wehdat});

  @override
  State<LessonsWidget> createState() => _LessonsWidgetState();
}

class _LessonsWidgetState extends State<LessonsWidget> {
  int expanded = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.wehdat.length,
        itemBuilder: (context, index) {
          return _buildLessonItem(widget.wehdat, widget.wehdat[index], index, expanded, (index) {
            setState(() {
              if (expanded == index) {
                expanded = -1;
              } else {
                expanded = index;
              }
            });
          });
        });
  }

  Widget _buildLessonItem(List<Wehda> wehdat, Wehda wehda, int index, int expanded, Function(int) expand) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: InkWell(
            onTap: () {
              expand(index);
            },
            child: Container(
                padding: const EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                    color: ColorManager.white
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        wehda.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: ColorManager.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s4,),
                    Icon(
                      expanded == index ? Icons.expand_less : Icons.expand_more,
                      color: ColorManager.black,
                    ),
                  ],
                )
            ),
          ),
        ),
        expanded == index ?
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wehda.lessons.length,
            itemBuilder: (context, lessonIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p8),
                child: InkWell(
                  onTap: () {
                    CoursesController controller = Get.find<CoursesController>();
                    Course course = controller.course.value;
                    controller.selectedLesson = wehda.lessons[lessonIndex].obs;
                    controller.course.value = course;
                    Get.back();
                    Get.to(const LessonScreen());
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorManager.secondary, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            lessonIndex < 9 ? '0${lessonIndex + 1}' : '${lessonIndex + 1}',
                            style: getLargeStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.secondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0,),
                      SizedBox(
                        width: 200,
                        child: Text(
                          wehda.lessons[lessonIndex].title,
                          style: getSmallStyle(
                            color: ColorManager.black
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ) : Container()
      ],
    );
  }
}