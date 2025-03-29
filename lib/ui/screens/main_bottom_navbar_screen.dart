import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../utils/custom_color.dart';
import 'bottom_nav_screen/home_screen.dart';
import 'bottom_nav_screen/profile_screen.dart';
import 'bottom_nav_screen/tab_status_screen.dart';
import 'bottom_nav_screen/add_new_task_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    HomeScreen(),
    AddNewTaskScreen(),
    TabStatusScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _screens[_selectedIndex]),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GNav(
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 350),
          color: Colors.grey[800],
          activeColor: CustomBNColors.foregrounds[_selectedIndex],
          iconSize: 24,
          tabBackgroundColor: CustomBNColors.backgrounds[_selectedIndex],
          padding: const EdgeInsets.all(15),
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            _selectedIndex = value;
            setState(() {});
          },
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
    );
  }
}
