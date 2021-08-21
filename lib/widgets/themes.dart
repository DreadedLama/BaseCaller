import 'package:flutter/material.dart';

class MyTheme {
  static ThemeMode get darkThemeMode => ThemeMode.dark;

  static ThemeMode get lightThemeMode => ThemeMode.light;

  static ThemeData get darkTheme => ThemeData(brightness: Brightness.dark);

  static ThemeData get lightTheme => ThemeData(brightness: Brightness.light);
}
