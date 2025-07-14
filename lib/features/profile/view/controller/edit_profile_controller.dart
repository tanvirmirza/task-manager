import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/core/api/model/api_response.dart';
import 'package:task_manager/core/api/repository/network_caller_dio.dart';
import 'package:task_manager/core/constants/app_urls.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/logger.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';

class ProfileEditController extends GetxController {
  final prefs = SharedPreferencesHelper();

  final isNewObscure = true.obs;
  final isConfirmObscure = true.obs;
  final isLoading = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Rx<XFile?> profileImage = Rx<XFile?>(null);

  /// Toggle password visibility
  void toggleNewObscure() => isNewObscure.toggle();
  void toggleConfirmObscure() => isConfirmObscure.toggle();

  /// Pick image from gallery
  Future<void> pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        profileImage.value = picked;
      }
    } catch (e) {
      AppLoggerHelper.error('Image pick error: $e');
      _showError('Image Pick Failed', 'Unable to pick image. Please try again.');
    }
  }

  /// Update profile details without image
  Future<void> updateProfile() async {
    isLoading.value = true;

    final token = prefs.getString("token");
    if (token == null) {
      _showError('Unauthorized', 'Token not found. Please login again.');
      logout();
      isLoading.value = false;
      return;
    }


    final body = {
      "email": emailController.text.trim(),
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "mobile": mobileController.text.trim(),
    };

    final ResponseData response = await NetworkCaller.postRequest(
      AppUrls.updateProfileUrl,
      body: body,
      token: token
    );

    isLoading.value = false;

    if (response.isSuccess) {
      Get.snackbar(
        'Profile Updated',
        'Your profile has been updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      _showError('Update Failed', response.errorMessage);
    }
  }

  /// Upload profile image separately
  Future<void> uploadProfileImage() async {
    if (profileImage.value == null) return;

    isLoading.value = true;

    final File imageFile = File(profileImage.value!.path);
  }

  /// Logout user and clear preferences
  Future<void> logout() async {
    await prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  /// Dummy method for password change notification
  void changePassword() {
    Get.snackbar(
      'Password Changed',
      'Your password has been updated',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Helper for showing error snackbars
  void _showError(String title, String? message) {
    Get.snackbar(
      title,
      message ?? 'Something went wrong. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
