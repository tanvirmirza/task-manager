import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/custom_color.dart';
import '../../widgets/tm_app_bar.dart';
import '../task_screens/cencelled_task_screen.dart';
import '../task_screens/completed_task_screen.dart';
import '../task_screens/progerss_task_screen.dart';

class TabStatusScreen extends StatefulWidget {
  const TabStatusScreen({super.key});

  @override
  State<TabStatusScreen> createState() => _TabStatusScreenState();
}

class _TabStatusScreenState extends State<TabStatusScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 56),
          child: TMAppBar(
            elevation: 0,
            bottom: TabBar(
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              indicatorPadding: const EdgeInsets.all(4),
              indicator: ShapeDecoration(
                  color: CustomTBColors.primary[_selectedIndex],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              labelColor: CustomTBColors.secondary[_selectedIndex],
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: const [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Progress',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      'Completed',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Cencelled',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
