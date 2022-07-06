import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontFamily: 'Lato',
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Anton',
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontFamily: 'Lato',
        fontSize: 14,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontFamily: 'Lato-Bold',
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Lato-Bold',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontFamily: 'Lato',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        // fontStyle:
      ),
    ),
    colorScheme: const ColorScheme.light(
      onPrimary: Colors.blue,
      onError: Colors.red,
      brightness: Brightness.light,
      primary: Colors.purpleAccent,
      secondary: Colors.blue,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontFamily: 'lato', color: Colors.white10),
      backgroundColor: Colors.blueAccent,
      brightness: Brightness.light,
      // textTheme:
    ),
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black12,
    primarySwatch: Colors.purple,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontFamily: 'Lato',
        fontSize: 20,
      ),
      // bodyText1: const TextStyle(
      //   color: Colors.white,
      //   fontFamily: 'Lato',
      //   fontSize: 20,
      // ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Anton',
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontFamily: 'Lato',
        fontSize: 14,
      ),
      headlineLarge: TextStyle(
        color: Colors.white,
        fontFamily: 'Lato-Bold',
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Lato-Bold',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontFamily: 'Lato',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        // fontStyle:
      ),
    ),
    colorScheme: const ColorScheme.dark(
      onPrimary: Colors.blue,
      onError: Colors.red,
      brightness: Brightness.light,
      primary: Colors.purpleAccent,
      secondary: Colors.blue,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontFamily: 'lato', color: Colors.white10),
      backgroundColor: Colors.lightBlueAccent,
      brightness: Brightness.dark,
      // textTheme:
    ),
  );
}
