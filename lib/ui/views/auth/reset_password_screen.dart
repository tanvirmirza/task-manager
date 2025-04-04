import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmNewpasswordTEController =
      TextEditingController();
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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Set a new password minimum length of 6 letters.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _newPasswordTEController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: 'New Password'),
                    style: Theme.of(context).textTheme.labelLarge,
                    validator: _validatePassword,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _confirmNewpasswordTEController,
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(hintText: 'Confirm New Password'),
                    style: Theme.of(context).textTheme.labelLarge,
                    validator: _validatePassword,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: const Text('Confirm')),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: RichText(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState?.validate() == true) {
      _onTapSignInButton();
    }
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (pre) => false);
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmNewpasswordTEController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (_newPasswordTEController.text !=
        _confirmNewpasswordTEController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
