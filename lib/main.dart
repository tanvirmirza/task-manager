<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/core/bindings/app_bindings.dart';
import 'package:task_manager/core/bindings/initial_binding.dart';
import 'package:task_manager/core/utils/shared_prefarenses_helper.dart';
=======

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
>>>>>>> Stashed changes
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

<<<<<<< Updated upstream
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await SharedPreferencesHelper().init();
  AppBinding().dependencies();
  InitialBinding().dependencies();

  runApp(const MyApp());
=======
  runApp( DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp())
  );
>>>>>>> Stashed changes
}
