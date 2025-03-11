import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  AppTextStyle._();
  static TextStyle appMediumTextStyle({
    double? size,
    FontWeight? fontWeight,
    Color? color,
    bool? isItalic,
    bool? isUnderline,
    Color? underlineColor,
    double? underlineThickness,
  }) {
    return GoogleFonts.poppins(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: size,
      color: color,
      fontStyle: isItalic == true ? FontStyle.italic : null,
      decoration: isUnderline == true ? TextDecoration.underline : null,
      decorationColor: underlineColor,
      decorationThickness: underlineThickness ?? 1.0,
    );
  }
}