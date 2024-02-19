import 'package:flutter/material.dart';

import '../../../../domain/models/notification.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/notification_item.dart';

class SubscriptionsScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص',
        '3 ساعة'),
    NotificationModel(
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص',
        '12 سبتمبر'),
    NotificationModel(
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص',
        '12 سبتمبر'),
  ];

  SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              return NotificationItem(
                notification: notifications[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
