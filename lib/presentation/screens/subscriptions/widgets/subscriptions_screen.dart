import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/resources/color_manager.dart';
import 'package:teacher/presentation/resources/styles_manager.dart';
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
                return ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const SizedBox(height: 8.0,),
                    Stack(
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
                                  Text(
                                    '0 د.ك',
                                    style: getSmallStyle(),
                                    textAlign: TextAlign.center,
                                  ),
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
                                  Text(
                                    '10',
                                    style: getSmallStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            right: 0,
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: VerticalDivider(width: 2, color: ColorManager.lightGrey,)
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: controller.notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationItem(
                          notificationString: controller.notifications[index].text ?? '',
                          action: () {  },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
