import 'package:flutter_feature_bites/controller/auth_controller/auth_controller.dart';
import 'package:flutter_feature_bites/view/auth/screen/login_screen.dart';
import 'package:flutter_feature_bites/view/home/screen/home_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() => Get.put(AuthController())),
    ),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    // Add more routes here
  ];
}
