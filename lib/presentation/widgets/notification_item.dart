import 'package:flutter/cupertino.dart';

import '../../domain/models/notification.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class NotificationItem extends StatelessWidget {

  final NotificationModel notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          color: const Color(0xffF2F2F2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            notification.text,
            style: getSmallStyle(
              fontSize: FontSize.s12
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                notification.time,
                style: getSmallStyle(
                    fontSize: FontSize.s12,
                    color: ColorManager.grey
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
