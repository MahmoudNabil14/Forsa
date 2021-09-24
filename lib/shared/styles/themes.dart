import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: defaultColor,
    titleSpacing: 20.0,
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed

  ),
  fontFamily: 'shop_font',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(

  fontFamily: 'ShopFont',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed

  )
);