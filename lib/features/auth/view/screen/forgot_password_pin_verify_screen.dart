import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/validator.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/core/widgets/screen_background.dart';
import 'package:task_manager/features/auth/controller/forgot_password_pin_verify_controller.dart';

class ForgotPasswordPinVerifyScreen extends StatelessWidget {
  ForgotPasswordPinVerifyScreen({super.key});

  final controller = Get.put(ForgotPasswordPinVerifyController());
  final validation = FormValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A 6 digit verification pin has been sent to your email.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),
                  PinCodeTextField(
                    appContext: context,
                    controller: controller.pinCodeController,
                    length: 6,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    validator: validation.validatePin,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),
                  AppButton(text: 'Verify', onTap: controller.onVerifyTap,),
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
                              ..onTap = ()=> AppRoutes.login,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
