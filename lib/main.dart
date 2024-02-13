import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:teacher/presentation/resources/theme_manager.dart';
import 'package:teacher/presentation/screens/auth/auth_controller.dart';
import 'package:teacher/presentation/screens/auth/login/widgets/login_screen.dart';
import 'package:teacher/presentation/screens/main_screen.dart';

import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await GetXDi().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final AuthController _controller = Get.find<AuthController>();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      home: _controller.isUserLoggedIn() ? const MainScreen()
          :
      const LoginScreen(),
      initialBinding: GetXDi(),
    );
  }
}