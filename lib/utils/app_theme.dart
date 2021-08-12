import 'package:flutter/material.dart';

class AppTheme {
  static const _green = Color(0xFF4bf660);
  static const gray = Color(0xFF4c5261);
  static const yellow = Color(0xFFf6cb4b);

  static final _checkBoxTh = CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color>(_green),
    checkColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: _green,
    scaffoldBackgroundColor: Colors.white,
    checkboxTheme: _checkBoxTh,
    fontFamily: 'IBM_Plex',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 3.0,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _green,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(gray))
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _green,
    scaffoldBackgroundColor: Colors.black,
    checkboxTheme: _checkBoxTh,
    fontFamily: 'IBM_Plex',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff151515),
      elevation: 3.0,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff151515)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _green,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(foregroundColor: MaterialStateProperty.all(gray))
    ),
  );
}
