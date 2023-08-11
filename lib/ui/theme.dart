import 'package:flutter/material.dart';
import 'package:traffix/constants/colors.dart';

ThemeData kAppTheme = ThemeData(
    primaryColor: kPrimaryColor,
    highlightColor: kHighlightColor,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
    fontFamily: 'PlayFair',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 34,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      displaySmall: TextStyle(
          color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
      headlineMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 13,
          fontFamily: 'Roboto'),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      bodyLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 15,
          fontFamily: 'Roboto',
          height: 1.4),
      bodySmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Roboto'),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: kAccentColor)
        .copyWith(background: kPrimaryColor));

class CustomTheme {
  const CustomTheme();

  static const Color loginGradientStart = Color(0xFFfbab66);
  static const Color loginGradientEnd = Color(0xFFf7418c);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}