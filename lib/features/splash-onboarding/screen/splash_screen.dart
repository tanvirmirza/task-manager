import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:task_manager/core/constants/icon_path.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/splash-onboarding/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Image.asset(
                IconPath.appLogo,
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 70),
            child: SpinKitCircle(color: AppColors.primary, size: 50),
          ),
        ],
      ),
    );
  }
}
