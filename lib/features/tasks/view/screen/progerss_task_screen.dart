import 'package:flutter/material.dart';
import 'package:task_manager/core/core.dart';

import '../../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return TaskCard(
            taskStatus: TaskStatus.progress,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 2),
      ),
    );
  }
}
