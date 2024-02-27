import 'package:flutter/material.dart';
import 'package:teacher/presentation/resources/color_manager.dart';

import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class NotificationItem extends StatelessWidget {

  final String notificationTitle;
  final String notificationDesc;
  final Function() action;
  const NotificationItem({super.key, required this.notificationTitle, required this.action, required this.notificationDesc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: action,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: ColorManager.lightGrey,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationTitle,
                style: getLargeStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.secondary,
                ),
              ),
              Text(
                notificationDesc,
                style: getSmallStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
