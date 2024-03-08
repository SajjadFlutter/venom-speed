import 'package:flutter/material.dart';

class MyTheme {
  // default theme
  static final defaultTheme = ThemeData(
    fontFamily: 'iransans',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Colors.grey.shade900,
        fontSize: 16.0,
      ),
      labelMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 14.0,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 12.0,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFffb11b), width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),

      // این بخش می‌تواند دیگر ویژگی‌های استایل را نیز شامل شود
    ),
    scaffoldBackgroundColor: const Color(0xff07074f),
    primaryColor: const Color(0xFFffb11b),
    cardColor: const Color(0xFF27286b),
  );
}
