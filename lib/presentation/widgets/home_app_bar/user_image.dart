import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teacher/presentation/screens/courses/controller/courses_controller.dart';

import '../../resources/assets_manager.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CoursesController>(
      init: Get.find<CoursesController>(),
      builder: (CoursesController controller) {
        return controller.teacherImage.value == ImageAssets.user ? Image.asset(
          ImageAssets.user,
          height: 40,
          width: 40,
        ) : Image.network(
          controller.teacherImage.value,
          height: 40,
          width: 40,
        );
      },
    );
  }
}
