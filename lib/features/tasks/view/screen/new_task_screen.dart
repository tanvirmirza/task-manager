import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/features/tasks/controller/new_task_controller.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({super.key});

  final NewTaskController controller = Get.put(NewTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Tasks")),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (controller.newTaskList.isEmpty) {
            return RefreshIndicator(
              onRefresh: controller.fetchNewTasks,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      'No new tasks found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.fetchNewTasks,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: controller.newTaskList.length,
              itemBuilder: (context, index) {
                final task = controller.newTaskList[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Text(
                      task.createdDate.toLocal().toString().split(' ').first,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
            ),
          );
        }),
      ),
    );
  }
}
