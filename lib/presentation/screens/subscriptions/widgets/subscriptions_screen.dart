import 'package:flutter/material.dart';

import '../../../widgets/home_app_bar/home_app_bar.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          const Placeholder(),
        ],),
    );
  }
}
