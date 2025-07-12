

import 'package:task_manager/features/tasks/model/task_model.dart';

class TaskListModel {
  late final String status;
  late final List<TaskModel> taskList;

  TaskListModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    if (jsonData['data'] != null) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> data in jsonData['data']) {
        list.add(TaskModel.fromJson(data));
      }
      taskList = list;
    } else {
      taskList = [];
    }
  }
}