import 'package:flutter/material.dart';
import 'package:task_manager/ui/views/home/main_bottom_navbar_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color.fromRGBO(35, 75, 118, 1),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15),
            hoverColor: Colors.white,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            errorBorder: _getBorderNone(),
            enabledBorder: _getBorderNone(),
            border: _getBorderNone(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(88, 134, 183, 1),
                  foregroundColor: Colors.white,
                  fixedSize: const Size.fromWidth(double.maxFinite),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        home: const BottomNavBarScreen());
  }

  OutlineInputBorder _getBorderNone() {
    return OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5));
  }
}
