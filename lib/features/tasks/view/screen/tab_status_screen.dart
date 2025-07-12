import 'package:flutter/material.dart';
import 'package:task_manager/core/widgets/tm_app_bar.dart';
import 'package:task_manager/features/tasks/view/screen/cencelled_task_screen.dart';
import 'package:task_manager/features/tasks/view/screen/completed_task_screen.dart';
import 'package:task_manager/features/tasks/view/screen/new_task_screen.dart';
import 'package:task_manager/features/tasks/view/screen/progerss_task_screen.dart';

class TabStatusScreen extends StatefulWidget {
  const TabStatusScreen({super.key});

  @override
  State<TabStatusScreen> createState() => _TabStatusScreenState();
}

class _TabStatusScreenState extends State<TabStatusScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 56),
          child: TMAppBar(
            elevation: 0,
            bottom: TabBar(
              isScrollable: true,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              dividerColor: Colors.transparent,
              indicatorPadding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
              indicator: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18))),
              labelColor: Theme.of(context).colorScheme.primary,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: const [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'New',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Progress',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Completed',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
