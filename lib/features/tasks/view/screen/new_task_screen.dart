import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/utils/utils_class.dart';
import 'package:task_manager/features/tasks/controller/new_task_controller.dart';
import 'package:task_manager/features/tasks/view/widget/task_card.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({super.key});

  final controller = Get.put(TaskListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }else if(controller.tasks.isEmpty){
          return const Center(child: Text('No new tasks found.'));
        }else{
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              debugPrint("=====================>>$task");
              return TaskCard(
                taskStatus: TaskStatus.sNew,
                title: task.title,
                description: task.description,
                createdDate: task.createdDate,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
        }




      }),
    );
  }
}
