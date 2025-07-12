import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/utils_class.dart';
import 'package:task_manager/features/tasks/view/widget/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return const TaskCard(
            taskStatus: TaskStatus.cancelled,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 2),
      ),
    );
  }
}
