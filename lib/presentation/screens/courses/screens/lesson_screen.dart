import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';

import '../../../resources/color_manager.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/loading_screen.dart';
import '../widgets/course_tabs.dart';
import '../widgets/vimeo_video_widget.dart';

class LessonScreen extends StatefulWidget {

  const LessonScreen({super.key});

  @visibleForTesting
  String extractVideoId(String url) {
    RegExp regExp = RegExp(r'/(\d+)\??');
    Match? match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw Exception('Video ID not found in URL');
    }
  }

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetX<CoursesController>(
            init: Get.find<CoursesController>(),
            builder: (CoursesController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              } else if (controller.tutorials.isEmpty) {
                return const EmptyScreen(emptyString: AppStrings.emptyTutorials);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vimeo Video
                  controller.selectedLesson.value.link == '' ? const SizedBox(height: 60.0,) : SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: PlayVideoFromVimeo(vimeoVideoUrl: widget.extractVideoId(
                        controller.selectedLesson.value.link == '' ?
                        controller.tutorials[0].lessons[0].link : controller.selectedLesson.value.link)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      right: 16.0,
                      left: 16.0,
                      bottom: 0.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.course.value.name ?? '',
                          style: getLargeStyle(),
                        ),
                        Text(
                          controller.selectedLesson.value.title,
                          style: getLargeStyle(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0,),
                  Expanded(
                    child: CourseTabs(link: controller.selectedLesson.value.pdf, courseId: controller.course.value.id ?? -1),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, right: 8.0),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorManager.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}