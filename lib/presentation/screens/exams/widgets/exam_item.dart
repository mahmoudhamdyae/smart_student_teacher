import 'package:flutter/material.dart';

import '../../../../core/download_note.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ExamItem extends StatelessWidget {

  final String text;
  final String link;
  const ExamItem({super.key, required this.text, required this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => downloadExam(context, link),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              color: ColorManager.lightGrey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: getSmallStyle(),
              ),
              const Icon(Icons.download),
            ],
          ),
        ),
      ),
    );
  }
}
