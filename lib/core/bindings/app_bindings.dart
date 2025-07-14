import 'package:get/get.dart';
import 'package:task_manager/features/auth/controller/forgot_password_pin_verify_controller.dart';
import 'package:task_manager/features/auth/controller/forgot_password_verify_controller.dart';
import 'package:task_manager/features/auth/controller/login_controller.dart';
import 'package:task_manager/features/auth/controller/register_controller.dart';
import 'package:task_manager/features/auth/controller/reset_password_controller.dart';
import 'package:task_manager/features/home/controller/bottom_nav_controller.dart';
import 'package:task_manager/features/home/controller/home_controller.dart';
import 'package:task_manager/features/profile/view/controller/edit_profile_controller.dart';
import 'package:task_manager/features/profile/view/controller/profile_view_controller.dart';
import 'package:task_manager/features/splash-onboarding/controller/onboarding_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => RegisterController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordVerifyController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordPinVerifyController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileViewController(), fenix: true);
    Get.lazyPut(() => ProfileEditController(), fenix: true);
  }
}