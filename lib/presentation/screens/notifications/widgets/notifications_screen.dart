import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/notification_item.dart';
import 'reply_comment_screen.dart';
import '../controller/notifications_controller.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await Get.find<NotificationsController>().getNotifications(),
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            HomeAppBar(),
            GetX<NotificationsController>(
              init: Get.find<NotificationsController>(),
              builder: (NotificationsController controller) {
                if (controller.status.isLoading) {
                  return const LoadingScreen();
                } else if (controller.status.isError) {
                  return ErrorScreen(error: controller.status.errorMessage ?? '');
                } else if (controller.comments.isEmpty){
                  return const EmptyScreen(emptyString: AppStrings.noNotifications);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationItem(
                      notificationString: controller.comments[index].comment ?? '',
                      action: () {
                        controller.selectedComment.value = controller.comments[index];
                        Get.to(() => const ReplyCommentScreen());
                      },
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
