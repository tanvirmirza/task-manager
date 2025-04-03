
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'provider/image_provider.dart';

void main() {

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ImagePickProvider())
  ],child: DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp())
  ));
}



