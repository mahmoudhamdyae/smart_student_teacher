import 'package:flutter/cupertino.dart';

import '../../resources/assets_manager.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssets.user,
      height: 40,
      width: 40,
    );
  }
}
