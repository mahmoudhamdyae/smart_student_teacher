import 'package:flutter/material.dart';

import 'comments_list.dart';

class TabComments extends StatelessWidget {

  final int courseId;
  const TabComments({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: CommentsList(),
    );
  }
}
