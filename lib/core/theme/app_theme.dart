import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_case/core/theme/app_colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.bgColor,
    textTheme: GoogleFonts.robotoTextTheme(),
    floatingActionButtonTheme: floatingActionButtonThemeData,
  );
}

FloatingActionButtonThemeData floatingActionButtonThemeData =
    FloatingActionButtonThemeData(
  backgroundColor: AppColor.bgColor,
);
