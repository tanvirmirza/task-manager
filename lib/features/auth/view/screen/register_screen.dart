// register_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/validator.dart';
import 'package:task_manager/core/widgets/screen_background.dart';
import 'package:task_manager/core/widgets/app_text_field.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/features/auth/controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controller = Get.put(RegisterController());
  final validation = FormValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create an account to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),

                  AppTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: validation.validateEmail,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),

                  AppTextField(
                    controller: controller.firstNameController,
                    hintText: 'First Name',
                    textInputAction: TextInputAction.next,
                    validator: validation.validateName,
                  ),
                  const SizedBox(height: 16),

                  AppTextField(
                    controller: controller.lastNameController,
                    hintText: 'Last Name',
                    textInputAction: TextInputAction.next,
                    validator: validation.validateName,
                  ),
                  const SizedBox(height: 16),

                  AppTextField(
                    controller: controller.mobileController,
                    hintText: 'Mobile',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: validation.validateMobile,
                  ),
                  const SizedBox(height: 16),

                  Obx(() {
                    return AppTextField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      obscureText: controller.isPasswordObscure.value,
                      textInputAction: TextInputAction.done,
                      validator: validation.validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    );
                  }),

                  const SizedBox(height: 16),

                  Obx(() {
                    return AppButton(
                      text: 'Sign Up',
                      onTap: controller.onSignUp,
                      isLoading: controller.isLoading.value,
                    );
                  }),

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
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: "Sign In",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}
