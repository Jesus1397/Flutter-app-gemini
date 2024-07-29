import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {
  static const extraSmall = 14.0;
  static const small = 16.0;
  static const standard = 18.0;
  static const large = 20.0;
  static const extraLarge = 24.0;
  static const doubleExtraLarge = 26.0;
}

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.white,
  ),
  colorScheme: const ColorScheme.light(
    surface: Color(0xffffffff),
    primary: Color(0xff3369FF),
    secondary: Color(0xffEEEEEE),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.blue),
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    const TextTheme(
      titleLarge: TextStyle(
        color: Color(0xff000000),
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: Color(0xff000000),
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: Color(0xff000000),
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: Color(0xff000000),
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    shadowColor: Color(0xff625b5b),
  ),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xff000000),
    primary: Color(0xff3369FF),
    secondary: Color(0xffEEEEEE),
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    const TextTheme(
      titleLarge: TextStyle(
        color: Color(0xffEEEEEE),
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: Color(0xffEEEEEE),
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: Color(0xffEEEEEE),
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: Color(0xffEEEEEE),
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);
