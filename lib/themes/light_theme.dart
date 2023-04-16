// ignore_for_file: deprecated_member_use

import 'package:si_bima/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    brightness: Brightness.light,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
    // scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.light().copyWith(primary: AppColors.primaryColor),
    splashColor: (GetPlatform.isIOS)
        ? Colors.transparent
        : Theme.of(context).splashColor,
    highlightColor: (GetPlatform.isIOS)
        ? Colors.grey.shade50
        : Theme.of(context).highlightColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: TextStyle(color: AppColors.black),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme.copyWith(
            caption: GoogleFonts.poppins(wordSpacing: 0.4, letterSpacing: 0.18),
            bodyText1: GoogleFonts.poppins(
              wordSpacing: 0.4,
              letterSpacing: 0.18,
              color: AppColors.black,
            ),
            bodyText2: GoogleFonts.poppins(
              wordSpacing: 0.4,
              letterSpacing: 0.18,
              color: AppColors.black,
            ),
            button: GoogleFonts.poppins(fontSize: 18),
            subtitle1: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.black,
                wordSpacing: 0.4,
                letterSpacing: 0.18),
            subtitle2: GoogleFonts.poppins(
                fontSize: 15,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                wordSpacing: 0.4,
                letterSpacing: 0.18),
            overline: GoogleFonts.poppins(fontSize: 11, color: AppColors.grey),
          ),
    ),
    inputDecorationTheme: InputDecorationTheme().copyWith(
      filled: true,
      fillColor: AppColors.inputBoxColor,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        textStyle: TextTheme().button,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
