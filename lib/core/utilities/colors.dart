import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static Color backGround = Color(0xFFDFECDB);
  static Color primary = Color(0xFF5D9CEC);
  static Color WhiteColor = Colors.white;
  static ThemeData light = ThemeData(
      appBarTheme: AppBarTheme(
        color: primary,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
        fontSize: 25,
        fontFamily: "Poppins",
      ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontFamily: "Poppins",
          )
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      )));
}
