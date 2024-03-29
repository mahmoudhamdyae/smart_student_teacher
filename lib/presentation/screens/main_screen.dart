import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:teacher/presentation/screens/books/widgets/books_screen.dart';
import 'package:teacher/presentation/screens/courses/screens/courses_screen.dart';
import 'package:teacher/presentation/screens/exams/screens/exams_courses_screen.dart';
import '../../core/check_version.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import 'notifications/widgets/notifications_screen.dart';

class MainScreen extends StatefulWidget {

  final int selectedIndex;
  const MainScreen({super.key, required this.selectedIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late PersistentTabController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _controller = PersistentTabController(initialIndex: _selectedIndex);
    try {
      versionCheck(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<Widget> _buildScreens() {
    return [
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: CoursesScreen(),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: BooksScreen(),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: ExamsCoursesScreen(),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: SubscriptionsScreen(),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 0;
            _controller.index = 0;
          });
        },
        icon: Text(AppStrings.bottomBarCourses, style: getLargeStyle(color: _selectedIndex == 0 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 1;
            _controller.index = 1;
          });
        },
        icon: Text(AppStrings.bottomBarBooks, style: getLargeStyle(color: _selectedIndex == 1 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 2;
            _controller.index = 2;
          });
        },
        icon: Text(AppStrings.exams, style: getLargeStyle(color: _selectedIndex == 2 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 3;
            _controller.index = 3;
          });
        },
        icon: Text(AppStrings.bottomBarNotifications, style: getLargeStyle(color: _selectedIndex == 3 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: ColorManager.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
        ),
        navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
      ),
    );
  }
}
