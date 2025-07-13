import 'package:get/get.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';

class OnboardingController extends GetxController {
  final prefs = SharedPreferencesHelper();

  void completeOnboarding() async {
    await prefs.setBool("isComplete", true);
    Get.offAllNamed(AppRoutes.login);
  }

}
