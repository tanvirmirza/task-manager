import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< Updated upstream
import 'package:task_manager/core/bindings/initial_binding.dart';
import 'package:task_manager/core/routes/app_pages.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/theme/app_theme.dart';
=======
import 'ui/views/auth/forgot_password_pin_verify_screen.dart';
import 'ui/views/auth/forgot_password_verify_screen.dart';
import 'ui/views/auth/login_screen.dart';
import 'ui/views/auth/register_screen.dart';
import 'ui/views/auth/reset_password_screen.dart';
import 'ui/views/home/main_bottom_navbar_screen.dart';
import 'ui/views/home/profile_edit_screen.dart';
import 'ui/views/splash/splash_screen.dart';
>>>>>>> Stashed changes

class MyApp extends StatelessWidget {
  const MyApp({super.key});
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
<<<<<<< Updated upstream
=======
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
>>>>>>> Stashed changes
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.splash,
        initialBinding: InitialBinding(),
        theme: appTheme,
        );
  }


}
