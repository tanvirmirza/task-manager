import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/validator.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/core/widgets/app_text_field.dart';
import 'package:task_manager/core/widgets/screen_background.dart';
import 'package:task_manager/features/auth/controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final controller = Get.find<ResetPasswordController>();
  final validation = FormValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Set a new password minimum length of 6 letters.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  hintText: 'New Password',
                  controller: controller.newPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  validator: validation.validatePassword,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controller.confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  hintText: 'Confirm New Password',
                  validator: (value){
                    validation.confirmPasswordValidator(value, controller.newPasswordController);
                    return null;
                  }
                ),
                const SizedBox(height: 16),
                AppButton(text: 'Confirm', onTap: controller.onSubmit,),
                const SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        const TextSpan(text: "Have account? "),
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = ()=> Get.toNamed(AppRoutes.login),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
