import 'package:flutter/material.dart';

import 'ui/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color.fromRGBO(35, 75, 118, 1),
            
            inputDecorationTheme: InputDecorationTheme(
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
                    
                hoverColor: Colors.white,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                errorBorder: _getBorderNone(),
                enabledBorder: _getBorderNone(),
                border: _getBorderNone(),),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(35, 75, 118, 1),
                    foregroundColor: Colors.white,
                    fixedSize: const Size.fromWidth(double.maxFinite),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ))),
            textTheme: const TextTheme(
                titleLarge:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    
                labelLarge:TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    
                    ),
        home: const SplashScreen());
  }

  OutlineInputBorder _getBorderNone() {
    return OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5));
  }
}
