import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/resources/strings_manager.dart';
import 'package:teacher/presentation/screens/notifications/controller/notifications_controller.dart';
import 'package:teacher/presentation/widgets/top_bar.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/constants_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class ReplyCommentScreen extends StatelessWidget {

  const ReplyCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBar(title: AppStrings.bottomBarComments,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: GetX<NotificationsController>(
                init: Get.find<NotificationsController>(),
                builder: (NotificationsController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.selectedNotification.value.from ?? '',
                        style: getLargeStyle(),
                      ),
                      Text(
                        controller.selectedNotification.value.body ?? '',
                        style: getSmallStyle(),
                      ),
                    ],
                  );
                  },
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  TextFormField(
                    controller: Get.find<NotificationsController>().commentEditText,
                    onChanged: (newComment) => Get.find<NotificationsController>().updateComment(newComment),
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
                        NotificationsController controller = Get.find<NotificationsController>();
                        controller.addComment().then((value) {
                          Get.back();
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
