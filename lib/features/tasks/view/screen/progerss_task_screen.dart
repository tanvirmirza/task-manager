import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/utils_class.dart';
import 'package:task_manager/features/tasks/view/widget/task_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({Key? key}) : super(key: key);

  static const int taskCount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('In Progress Tasks')),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: taskCount,
        itemBuilder: (context, index) {
          return TaskCard(
            taskStatus: TaskStatus.progress,
            title: "Title $index",
            description: '',
            createdDate: DateTime.now(),

            // optionally, pass static title, description here if needed
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
