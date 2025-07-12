import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordObscure = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordObscure.value = !isPasswordObscure.value;
  }

  Future<void> onSignUp() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.offAllNamed(AppRoutes.nav);
  }

  @override
  void onClose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
