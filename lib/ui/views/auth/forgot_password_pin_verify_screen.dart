import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'login_screen.dart';
import 'reset_password_screen.dart';

class ForgotPasswordPinVerifyScreen extends StatefulWidget {
  const ForgotPasswordPinVerifyScreen({super.key});

  @override
  State<ForgotPasswordPinVerifyScreen> createState() =>
      _ForgotPasswordPinVerifyScreenState();
}

class _ForgotPasswordPinVerifyScreenState
    extends State<ForgotPasswordPinVerifyScreen> {
  final TextEditingController _pinCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit verification pin has been send to your email.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _pinCodeTEController,
                    validator: _validatePinCode,
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: _onTapResetPasswordButton,
                      child: const Text('Verify')),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                                children: [
                              const TextSpan(text: "Have account? "),
                              TextSpan(
                                  text: "Sign In",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignInButton),
                            ])),
                      ],
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

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (pre) => false);
  }

  void _onTapResetPasswordButton() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
    }
  }

  @override
  void dispose() {
    _pinCodeTEController.dispose();
    super.dispose();
  }

  String? _validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pin code cannot be empty';
    } else if (value.length != 6) {
      return 'Pin code must be 6 digits';
    }
    return null;
  }
}
