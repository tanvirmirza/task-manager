import 'package:flutter/material.dart';

import '../../widgets/progress_box.dart';
import '../../widgets/task_progress_tile.dart';
import '../../widgets/tm_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your Progress",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 20),
              GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: const [
                  ProgressBox(
                    centerText: '70%',
                    footerText: 'Overall Progress',
                    percent: 0.7,
                    centerTextColor: Colors.blueAccent,
                    progressColor: Colors.blue,
                  ),
                  ProgressBox(
                      progressColor: Colors.orange,
                      centerTextColor: Colors.orangeAccent,
                      footerText: "Progress Tasks",
                      centerText: "40%",
                      percent: 0.4),
                  ProgressBox(
                    centerText: '100%',
                    footerText: 'Completed Tasks',
                    percent: 1.0,
                    centerTextColor: Colors.greenAccent,
                    progressColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Task List",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const TaskProgressTile(
                  title: "Design Homepage",
                  progress: 0.8,
                  color: Colors.green,
                  status: "In Progress",
                  icon: Icons.design_services),
              const TaskProgressTile(
                  title: "API Integration",
                  progress: 1.0,
                  color: Colors.blue,
                  status: "Completed",
                  icon: Icons.check_circle),
              const TaskProgressTile(
                  title: "Fix Bugs",
                  progress: 0.0,
                  color: Colors.red,
                  status: "Cancelled",
                  icon: Icons.cancel),
              const TaskProgressTile(
                  title: "Write Documentation",
                  progress: 0.6,
                  color: Colors.orange,
                  status: "In Progress",
                  icon: Icons.description)
            ],
          ),
        ),
      ),
    );
  }
}
