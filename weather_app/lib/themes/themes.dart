import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.crushedTextTheme(),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xff5F5F5F),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.crushedTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xff303553),
    useMaterial3: true,
  );
}