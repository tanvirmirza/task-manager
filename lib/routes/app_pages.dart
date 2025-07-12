import 'package:get/get.dart';
import 'package:task_manager/features/auth/view/screen/forgot_password_pin_verify_screen.dart';
import 'package:task_manager/features/auth/view/screen/forgot_password_verify_screen.dart';
import 'package:task_manager/features/auth/view/screen/login_screen.dart';
import 'package:task_manager/features/auth/view/screen/register_screen.dart';
import 'package:task_manager/features/auth/view/screen/reset_password_screen.dart';
import 'package:task_manager/features/home/view/screen/main_bottom_navbar_screen.dart';
import 'package:task_manager/features/profile/view/screen/profile_edit_screen.dart';
import 'package:task_manager/features/splash%20onboarding/screen/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(
        name: AppRoutes.verify, page: () => const ForgotPasswordVerifyScreen()),
    GetPage(
        name: AppRoutes.pinVerify,
        page: () => const ForgotPasswordPinVerifyScreen()),
    GetPage(name: AppRoutes.reset, page: () => const ResetPasswordScreen()),
    GetPage(name: AppRoutes.nav, page: () => const BottomNavBarScreen()),
    GetPage(name: AppRoutes.profileEdit, page: () => const ProfileEditScreen()),
    // Add more routes here
  ];
}
