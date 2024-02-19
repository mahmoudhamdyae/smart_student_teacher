import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';
import 'package:teacher/presentation/screens/courses/widgets/comment_item.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/loading_screen.dart';

class CommentsList extends StatelessWidget {

  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CoursesController>(
      init: Get.find<CoursesController>(),
      builder: (CoursesController controller) {
        if (controller.getCommentsStatus.isLoading) {
          return const LoadingScreen();
        } else if (controller.getCommentsStatus.isError) {
          return ErrorScreen(error: controller.getCommentsStatus.errorMessage ?? '');
        } else if (controller.comments.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                AppStrings.noComments,
                style: getLargeStyle(),
              ),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: controller.comments.length,
          itemBuilder: (BuildContext context, int index) {
            return CommentItem(comment: controller.comments[index]);
          },
        );
      },
    );
  }
}
