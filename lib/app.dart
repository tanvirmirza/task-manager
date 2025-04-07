import 'package:flutter/material.dart';
import 'ui/views/auth/forgot_password_pin_verify_screen.dart';
import 'ui/views/auth/forgot_password_verify_screen.dart';
import 'ui/views/auth/login_screen.dart';
import 'ui/views/auth/register_screen.dart';
import 'ui/views/auth/reset_password_screen.dart';
import 'ui/views/home/main_bottom_navbar_screen.dart';
import 'ui/views/home/profile_edit_screen.dart';
import 'ui/views/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/loginScreen': (context) => const LoginScreen(),
          '/registerScreen': (context) => const RegisterScreen(),
          '/forgetPasswordVerifyScreen': (context) =>
              const ForgotPasswordVerifyScreen(),
          '/forgetPasswordPinVerifyScreen': (context) =>
              const ForgotPasswordPinVerifyScreen(),
          '/resetPasswordScreen': (context) => const ResetPasswordScreen(),
          '/bottomNavScreen': (context) => const BottomNavBarScreen(),
          '/profileEditScreen': (context) => const ProfileEditScreen(),
        },
        theme: ThemeData(
          colorSchemeSeed: const Color.fromRGBO(35, 75, 118, 1),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
            hoverColor: Colors.white,
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            errorBorder: _getBorderNone(),
            enabledBorder: _getBorderNone(),
            border: _getBorderNone(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.maxFinite),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: const Color.fromRGBO(35, 75, 118, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4)),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        home: const SplashScreen());
  }

  OutlineInputBorder _getBorderNone() {
    return OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10));
  }
}
