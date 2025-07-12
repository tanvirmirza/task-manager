import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';

class ForgotPasswordPinVerifyController extends GetxController {
  final pinCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onVerifyTap() {
    if (formKey.currentState?.validate() == true) {
      Get.toNamed(AppRoutes.nav);
    }
  }



  @override
  void onClose() {
    pinCodeController.dispose();
    super.onClose();
  }
}
