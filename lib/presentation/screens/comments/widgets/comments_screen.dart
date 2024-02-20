import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/comments/controller/comments_controller.dart';
import 'package:teacher/presentation/screens/comments/widgets/reply_comment_screen.dart';

import '../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/notification_item.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await Get.find<CommentsController>().getComments(),
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            HomeAppBar(),
            GetX<CommentsController>(
              init: Get.find<CommentsController>(),
              builder: (CommentsController controller) {
                if (controller.status.isLoading) {
                  return const LoadingScreen();
                } else if (controller.status.isError) {
                  return ErrorScreen(error: controller.status.errorMessage ?? '');
                } else if (controller.comments.isEmpty){
                  return const EmptyScreen(emptyString: AppStrings.noCommentsScreen);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.find<CommentsController>().selectedComment.value = controller.comments[index];
                        Get.to(() => const ReplyCommentScreen());
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      child: NotificationItem(
                        notificationString: controller.selectedComment.value.comment ?? '',
                        action: () {
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
