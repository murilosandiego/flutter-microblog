import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final primaryColor = Color(0xFF1E70AB);
  final primaryColorDark = Color(0xFF1E70AE);
  final primaryColorLight = Color(0xFF8DC640);
  final secondaryColor = Color(0xFF3A93CC);
  final secondaryColorDark = Color(0xFF3A93CC);
  final disabledColor = Colors.grey[400];
  final dividerColor = Colors.grey;
  final textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColorDark,
    ),
    headline6: TextStyle(
      fontSize: 18,
    ),
  );
  final inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    fillColor: Color(0XFFF0F0F0),
    filled: true,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(25)),
    alignLabelWithHint: true,
  );
  final buttonTheme = ButtonThemeData(
    colorScheme: ColorScheme.light(primary: primaryColor),
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
  );

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    highlightColor: secondaryColor,
    secondaryHeaderColor: secondaryColorDark,
    disabledColor: disabledColor,
    dividerColor: dividerColor,
    accentColor: primaryColor,
    backgroundColor: Colors.white,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    buttonTheme: buttonTheme,
  );
}
