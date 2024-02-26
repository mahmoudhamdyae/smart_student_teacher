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
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          RefreshIndicator(
            onRefresh: () async => await Get.find<NotificationsController>().getNotifications(),
            child: GetX<NotificationsController>(
              init: Get.find<NotificationsController>(),
              builder: (NotificationsController controller) {
                if (controller.status.isLoading) {
                  return const LoadingScreen();
                } else if (controller.status.isError) {
                  return ErrorScreen(error: controller.status.errorMessage ?? '');
                } else if (controller.notifications.isEmpty){
                  return const EmptyScreen(emptyString: AppStrings.noNotifications);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(controller.notifications[index].id.toString()),
                      onDismissed: (direction) {
                        controller.delNotification(controller.notifications[index].id ?? -1, index);
                      },
                      child: NotificationItem(
                        notificationTitle: controller.notifications[index].title ?? '',
                        notificationDesc: controller.notifications[index].body ?? '',
                        action: () {
                          controller.selectedNotification.value = controller.notifications[index];
                          if (controller.selectedNotification.value.route?.type == 'comment') {
                            Get.to(() => const ReplyCommentScreen());
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
