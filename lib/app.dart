import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/bindings/initial_binding.dart';
import 'package:task_manager/core/routes/app_pages.dart';
import 'package:task_manager/core/routes/app_routes.dart';
import 'package:task_manager/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.splash,
        initialBinding: AppBinding(),
        theme: appTheme,
        );
  }


}
