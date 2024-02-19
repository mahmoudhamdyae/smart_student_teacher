import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/subscriptions/controller/subscriptions_controller.dart';

import '../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/notification_item.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await Get.find<SubscriptionsController>().getSubscriptions(),
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            HomeAppBar(),
            GetX<SubscriptionsController>(
              init: Get.find<SubscriptionsController>(),
              builder: (SubscriptionsController controller) {
                if (controller.status.isLoading) {
                  return const LoadingScreen();
                } else if (controller.status.isError) {
                  return ErrorScreen(error: controller.status.errorMessage ?? '');
                } else if (controller.notifications.isEmpty){
                  return const EmptyScreen(emptyString: AppStrings.noSubscriptions);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationItem(
                      notification: controller.notifications[index],
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
