import 'package:flutter/material.dart';

import '../../../../domain/models/notification.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/notification_item.dart';

class CommentsScreen extends StatelessWidget {
  final List<NotificationModel> notifications = List.generate(20, (index) => NotificationModel(
      'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص',
      '3 ساعة')
  );

  CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await _getComments(),
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }

  Future<void> _getComments() async {
  }
}
