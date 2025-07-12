import 'package:get/get.dart';
import 'package:task_manager/features/auth/controller/login_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
