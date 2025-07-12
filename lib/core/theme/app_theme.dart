import 'package:flutter/material.dart';
final ThemeData appTheme = ThemeData(
  colorSchemeSeed: const Color(0xFF234B76), // Color.fromRGBO(35, 75, 118, 1)
  inputDecorationTheme: _inputDecorationTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  textTheme: _textTheme,
);

// Input Decoration Theme
final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  hintStyle: const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  ),
  hoverColor: Colors.white,
  filled: true,
  fillColor: Colors.grey[200],
  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  errorBorder: _getBorderNone(),
  enabledBorder: _getBorderNone(),
  border: _getBorderNone(),
);

// Elevated Button Theme
final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    fixedSize: const Size.fromWidth(double.maxFinite),
    padding: const EdgeInsets.symmetric(vertical: 18),
    backgroundColor: const Color(0xFF234B76),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
  ),
);

// Text Theme
const TextTheme _textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  ),
  labelLarge: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  ),
);

// Reusable border style function (updated with radius 10)
OutlineInputBorder _getBorderNone() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  );
}
