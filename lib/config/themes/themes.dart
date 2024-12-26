import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: Colors.teal,
    hintColor: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
        ),
      ),
      titleLarge: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Colors.teal,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),

    appBarTheme: const AppBarTheme(
      // backgroundColor: Colors.blue,
      // elevation: 10,
      // shadowColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )
      )
    )
  );
}
