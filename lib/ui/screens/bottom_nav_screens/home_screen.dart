import 'package:flutter/material.dart';

import '../../widgets/tm_app_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
              Center(
                child: CircularPercentIndicator(
                  radius: 110.0,
                  lineWidth: 12.0,
                  percent: 0.7,
                  center: const Text("70%",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent)),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 1200,
                ),
              ),
              const SizedBox(height: 30),
              const Text("Task List",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              taskTile("Design Homepage", 0.8, Colors.green, "In Progress",
                  Icons.design_services),
              taskTile("API Integration", 1.0, Colors.blue, "Completed",
                  Icons.check_circle),
              taskTile("Fix Bugs", 0.0, Colors.red, "Cancelled", Icons.cancel),
              taskTile("Write Documentation", 0.6, Colors.orange, "In Progress",
                  Icons.description)
            ],
          ),
        ),
      ),
    );
  }

  Widget taskTile(String title, double progress, Color color, String status,
      IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            LinearProgressIndicator(
                value: progress,
                color: color,
                backgroundColor: Colors.grey.shade300,
                minHeight: 6),
            const SizedBox(height: 5),
            Text(status,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
