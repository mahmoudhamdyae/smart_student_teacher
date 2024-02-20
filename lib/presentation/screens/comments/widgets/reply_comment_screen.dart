import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/resources/strings_manager.dart';
import 'package:teacher/presentation/screens/comments/controller/comments_controller.dart';
import 'package:teacher/presentation/widgets/top_bar.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class ReplyCommentScreen extends StatelessWidget {

  const ReplyCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(title: AppStrings.bottomBarComments,),
        GetX<CommentsController>(
          init: Get.find<CommentsController>(),
          builder: (CommentsController controller) {
            return Text(controller.selectedComment.value.comment ?? '');
            },
        ),
        Expanded(child: Container()),
        ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            TextFormField(
              controller: Get.find<CommentsController>().commentEditText,
              onChanged: (newComment) => Get.find<CommentsController>().updateComment(newComment),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: getLargeStyle(
                fontSize: FontSize.s14,
                color: ColorManager.grey,
              ),
              decoration: getTextFieldDecoration(
                hint: AppStrings.yourComment,
                onPressed: () { },
                prefixIcon: Icons.comment,
              ),
            ),
            const SizedBox(height: 8.0,),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: getFilledButtonStyle(),
                onPressed: () {
                  CommentsController controller = Get.find<CommentsController>();
                  controller.addComment().then((value) {
                    Get.showSnackbar(
                      const GetSnackBar(
                        title: null,
                        message: AppStrings.commentAdded,
                        duration: Duration(seconds: AppConstants.snackBarTime),
                      ),
                    );
                  });},
                child: Text(
                  AppStrings.addComment,
                  style: getSmallStyle(
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
