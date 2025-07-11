import 'package:flutter_feature_bites/controller/auth_controller/auth_controller.dart';
import 'package:get/get.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AuthController());

  }
}

