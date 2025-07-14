import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/api/repository/network_caller_dio.dart';
import 'package:task_manager/core/constants/app_urls.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordObscure = true.obs;
  final isLoading = false.obs;

  final prefs = SharedPreferencesHelper();

  void togglePasswordVisibility() {
    isPasswordObscure.value = !isPasswordObscure.value;
  }

  Future<void> onSignUp() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    final body = {
      "email": emailController.text.trim(),
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "mobile": mobileController.text.trim(),
      "password": passwordController.text.trim(),
    };

    final ResponseData response = await NetworkCaller.postRequest(
      AppUrls.registerUrl,
      body: body,
    );

    isLoading.value = false;

    if (response.isSuccess) {
      final token = response.responseData['token'];
      if (token != null && token is String) {
        await prefs.setString("token", token);
      }

      await prefs.setBool("isLogIn", true);

      Get.offAllNamed(AppRoutes.nav);
    } else {
      Get.snackbar(
        'Registration Failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
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
