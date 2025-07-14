import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/api/repository/network_caller_dio.dart';
import 'package:task_manager/core/constants/app_urls.dart';
import 'package:task_manager/core/utils/logger.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';

class Category {
  final IconData icon;
  final String text;
  Category({required this.icon, required this.text});
}

class AddTaskController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final isLoading = false.obs;
  final selectedCategory = 'Work'.obs;

  final prefs = SharedPreferencesHelper();

  final categories = [
    Category(icon: Icons.work, text: 'Work'),
    Category(icon: Icons.school, text: 'Study'),
    Category(icon: Icons.health_and_safety, text: 'Health'),
    Category(icon: Icons.person, text: 'Personal'),
  ];

  Future<void> submit() async {

    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;

    final String ? token = prefs.getString("token");

    if (token == null) {
      isLoading.value = false;
      Get.snackbar(
        'Unauthorized',
        'Please login again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    AppLoggerHelper.debug(token);

    final body = {
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "status": "New",
    };

    final ResponseData response = await NetworkCaller.postRequest(
      AppUrls.createTaskUrl,
      body: body,
      token: token
    );

    isLoading.value = false;

    if (response.isSuccess) {
      Get.back();
      Get.snackbar(
        'Task Created',
        'Your task has been created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      titleController.clear();
      descriptionController.clear();
    } else {
      Get.snackbar(
        'Failed',
        response.errorMessage ?? 'Something went wrong.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
