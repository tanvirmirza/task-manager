import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'Email'),
                    style: Theme.of(context).textTheme.labelLarge,
                    validator: _emailValidator,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: 'Password'),
                    style: Theme.of(context).textTheme.labelLarge,
                    obscureText: true,
                    validator: _passwordValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: _onTapSingInButton,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(elevation: 0),
                            onPressed: _onTapForgetPasswordButton,
                            child: const Text('Forgot Password?')),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                                children: [
                              const TextSpan(text: "Don't have account? "),
                              TextSpan(
                                  text: "Sign Up",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton),
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

  void _onTapForgetPasswordButton() {
    Navigator.pushNamed(context, '/loginScreen');
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, '/registerScreen');
  }

  void _onTapSingInButton() {
    if (_formKey.currentState?.validate() == true) {
      if (_emailTEController.text == 'test@mail.com' &&
          _passwordTEController.text == '000000') {
        Navigator.pushNamedAndRemoveUntil(
          context,'/bottomNavScreen',
          (pre) => false,
        );
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
