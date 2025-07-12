import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';

class ForgotPasswordVerifyController extends GetxController {
  final email = ''.obs;
  final formKey = GlobalKey<FormState>();

  void onSubmit() {
    if (formKey.currentState?.validate() == true) {
      Get.toNamed(AppRoutes.pinVerify);
    }
  }

  void onSignIn() {
    Get.offAllNamed('/loginScreen');
  }
}
