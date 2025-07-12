// register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? validateName(String? value,) {
    if (value == null || value.isEmpty) return 'Name is required';
    if (value.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) return 'Mobile number is required';
    final mobileRegex = RegExp(r'^\d{10}$');
    if (!mobileRegex.hasMatch(value)) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void onSignInTap() {
    Get.back();
  }

  Future<void> onSignUp() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // mock API call delay
    isLoading.value = false;

    // You can replace this with your actual registration logic
    Get.offAllNamed('/bottomNavScreen');
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
