import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  void onAuthLogIn() async {
    if (formKey.currentState?.validate() == true) {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2)); // mock login delay

      isLoading.value = false;

      if (emailController.text == 'example@mail.com' &&
          passwordController.text == 'P@ssw0rd') {
        Get.toNamed(AppRoutes.nav);
      } else {
        Get.snackbar('Error', 'Invalid credentials',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
