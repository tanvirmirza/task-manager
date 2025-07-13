import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/core/bindings/app_bindings.dart';
import 'package:task_manager/core/bindings/initial_binding.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await SharedPreferencesHelper().init();
  AppBinding().dependencies();
  InitialBinding().dependencies();

  runApp(const MyApp());
}
