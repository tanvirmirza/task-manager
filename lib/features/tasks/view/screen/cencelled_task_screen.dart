import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/utils_class.dart';
import 'package:task_manager/features/tasks/view/widget/task_card.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 6,
        itemBuilder: (context, index) {
          return TaskCard(
            taskStatus: TaskStatus.cancelled,
            title: 'Cancelled Task ${index + 1}',
            description: 'Description for cancelled task ${index + 1}',
            createdDate: DateTime.now().subtract(Duration(days: index + 1)),
            isCompleted: false,
            onStatusChanged: null, // no action for cancelled tasks here
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
