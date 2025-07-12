import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/validator.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/core/widgets/app_text_field.dart';
import 'package:task_manager/core/widgets/screen_background.dart';
import 'package:task_manager/features/auth/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final controller = Get.put(LoginController());
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
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account to continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    hintText: 'Email',
                    controller: controller.emailController,
                    validator: validation.validateEmail,
                    textInputAction: TextInputAction.next,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.email_outlined),
                      onPressed: () =>
                      controller.emailController.text = 'example@mail.com',
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    hintText: 'Password',
                    controller: controller.passwordController,
                    validator: validation.validatePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.lock_outline),
                      onPressed: () =>
                      controller.passwordController.text = '01010101',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: ()=> Get.toNamed(AppRoutes.verify),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Obx(() {
                    return AppButton(
                      text: 'Sign In',
                      onTap: controller.onAuthLogIn,
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
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = ()=>Get.toNamed(AppRoutes.register),
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
