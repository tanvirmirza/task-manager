import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:task_manager/core/constants/custom_color.dart';
import 'package:task_manager/features/home/controller/bottom_nav_controller.dart';
import 'package:task_manager/features/profile/view/screen/profile_view_screen.dart';
import 'package:task_manager/features/tasks/view/screen/add_new_task_screen.dart';
import 'package:task_manager/features/tasks/view/screen/tab_status_screen.dart';
import 'home_screen.dart';
class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({super.key});

  final controller = Get.put(BottomNavController());

  final List<Widget> screens = [
    HomeScreen(),
    const AddNewTaskScreen(),
    const TabStatusScreen(),
    ProfileViewScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: screens[controller.selectedIndex.value],
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GNav(
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 400),
          color: Colors.grey[800],
          activeColor:
          CustomBNColors.foregrounds[controller.selectedIndex.value],
          iconSize: 24,
          tabBackgroundColor: CustomBNColors
              .backgrounds[controller.selectedIndex.value],
          padding: const EdgeInsets.all(15),
          gap: 8,
          selectedIndex: controller.selectedIndex.value,
          onTabChange: controller.updateIndex,
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: 'Home',
            ),
            GButton(
              icon: Icons.new_label,
              text: 'Add',
            ),
            GButton(
              icon: Icons.task_outlined,
              text: 'Status',
            ),
            GButton(
              icon: Icons.person_4_outlined,
              text: 'Profile',
            ),
          ],
        ),
      ),
    ));
  }
}
