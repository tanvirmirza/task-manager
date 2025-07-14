import 'package:get/get.dart';
import 'package:task_manager/features/auth/controller/login_controller.dart';
import 'package:task_manager/features/splash-onboarding/controller/splash_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
  }
}
