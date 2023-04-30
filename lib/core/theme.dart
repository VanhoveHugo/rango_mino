import 'package:flutter/material.dart';
import 'package:rango_mino/core/style.dart';
import 'package:rango_mino/core/color.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: ThemeColor.primary),
      centerTitle: true,
      titleTextStyle: appBar,
    ),
    scaffoldBackgroundColor: ThemeColor.white,
    hintColor: ThemeColor.grey75,
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: textFieldStyle,
      focusedBorder: textFieldStyle,
      filled: true,
      contentPadding: const EdgeInsets.all(20),
      fillColor: ThemeColor.grey250,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ThemeColor.white,
    ),
    iconTheme: const IconThemeData(color: ThemeColor.black),
    bottomAppBarTheme: const BottomAppBarTheme(color: ThemeColor.white),
  );
}