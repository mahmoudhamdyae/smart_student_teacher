import 'package:flutter/cupertino.dart';

import '../../../../domain/models/lesson.dart';
import '../../../resources/styles_manager.dart';

class CommentItem extends StatelessWidget {

  final Comments comment;
  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            comment.user?.name ?? '',
            style: getLargeStyle(),
          ),
          const SizedBox(width: 16.0,),
          Text(
            comment.comment ?? '',
            style: getSmallStyle(),
          ),
        ],
      ),
    );
  }
}
