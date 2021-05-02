import 'package:flutter/material.dart';
import 'package:shorty/views/util/HexColor.dart';

class ViewConstants {
  // App Name
  static String appName = "Shorty";

  // Shared Routes
  static const String homeRoute = '/home';
  static const String welcomeRoute = '/welcome';
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String anonymousRoute = '/anonymous';

  // User Routes
  static const String userProfileRoute = '/userProfile';

  // Admin Routes
  static const String adminProfileRoute = '/adminProfile';

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blue;
  static Color darkAccent = myBlack;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color myBlack = HexColor("#222831");
  static Color myLightBlack = HexColor("#393e46");
  static Color myPink = HexColor('#ff2e63');
  static Color myBlue = HexColor('#4267B3');
  static Color myWhite = HexColor('#fafafa');
  static Color myYellow = HexColor('#f0a500');
  static Color myGrey = HexColor('#393e46');
  static Color cosmicLatte = HexColor('#fff8e7');
  static Color myLightBlueTransparent = HexColor('#cffffe');
  static Color myLightGrey = HexColor('#eaeaea');
  static Color myGreyBlue = HexColor('CAE7FF');
  static Color darkGreyBlue = HexColor('040307');
  static Color myGreen = HexColor('17b978');

  static TextStyle fieldStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: HexColor("#ffffff"));
  static TextStyle hintStyle = TextStyle(color: ViewConstants.myBlack, fontSize: 13);
  static HexColor fieldBackgroundColor = ViewConstants.myWhite;
  static OutlineInputBorder fieldBorderStyle = new OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      const Radius.circular(20.0),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0, style: BorderStyle.none),
  );

  static ThemeData lightTheme = ThemeData(
    backgroundColor: myWhite,
    primaryColor: myBlue,
    accentColor: myBlue,
    cursorColor: myBlue,
    scaffoldBackgroundColor: myWhite,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
  );
}
