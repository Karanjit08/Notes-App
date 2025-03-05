import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: HexColor('#F8EEE2'), // background color of the screen
        secondaryContainer: Color(0xFFEFEFEF),
        primary: Color(0xFF000000), // most used text color
        onPrimary: Color(0xFF5A5A5A), // sub title lower text color
        secondary: Color(0xFFFFFFFF), // button text
        primaryContainer: HexColor('#d9614c') // button background color
        ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Color(0xFF000000), // background color of the screen
        secondaryContainer: Color(0xFF434343),
        primary: Color(0xFFFFFFFF), // most used text color
        onPrimary: Color(0xFF969696), // sub title lower text color
        secondary: Color(0xFF262626), // button text
        primaryContainer: HexColor('#d9614c') // button background color
        ));
