import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Colors.grey.shade600,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.black87,
      surface: Colors.grey.shade300,
      onSurface: Colors.black,
      tertiary: Colors.grey.shade700,
      inversePrimary: Colors.white
  )
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.grey.shade600,
        onPrimary: Colors.white,
        secondary: Colors.blueGrey,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.black87,
        surface: Colors.grey.shade900,
        onSurface: Colors.white,
        tertiary: Colors.grey.shade800,
        inversePrimary: Colors.grey.shade300
    )
);