import 'package:flutter/material.dart';

import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class NotificationItem extends StatelessWidget {

  final String notificationString;
  final Function() action;
  const NotificationItem({super.key, required this.notificationString, required this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: action,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: const Color(0xffF2F2F2),
              width: 1,
            ),
          ),
          child: Text(
            '${notificationString}',
            style: getSmallStyle(
                fontSize: FontSize.s12,
            ),
          ),
        ),
      ),
    );
  }
}
