import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';

class SplashController extends GetxController {
  final prefs = SharedPreferencesHelper();

  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    bool? isCompleted = prefs.getBool('isCompleted');
    bool? isLogIn = prefs.getBool('isLogIn');
    await Future.delayed(const Duration(seconds: 3));
    if (isCompleted == true) {
      if (isLogIn == true) {
        Get.offAllNamed(AppRoutes.nav);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
