import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/api/repository/network_caller_dio.dart';
import 'package:task_manager/core/constants/app_urls.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/logger.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final prefs = SharedPreferencesHelper();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  Future<void> onAuthLogIn() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    final body = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    final ResponseData response = await NetworkCaller.postRequest(
      AppUrls.loginUrl,
      body: body,
    );

    isLoading.value = false;

    if (response.isSuccess) {
      final data = response.responseData;
      final token = (data is Map<String, dynamic>) ? data['token'] : null;

      if (token != null && token is String && token.isNotEmpty) {
        await prefs.setString("token", token);
        AppLoggerHelper.debug(token);
      }

      await prefs.setBool("isLogIn", true);

      Get.offAllNamed(AppRoutes.nav);
    } else {
      Get.snackbar(
        'Login Failed',
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
    passwordController.dispose();
    super.onClose();
  }
}
