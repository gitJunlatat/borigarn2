import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextStyles {
  /// Text style for body
  static TextStyle h1 = TextStyle(
    fontSize: 48,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 48).fontFamily,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 32,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 32).fontFamily,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 24,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 24).fontFamily,
  );

  static TextStyle h4 = TextStyle(
    fontSize: 20,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 20).fontFamily,
  );

  /// Text style for heading

  static TextStyle subtitle = TextStyle(
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w400, fontSize: 20).fontFamily,
  );

  static TextStyle label1 = TextStyle(
    fontSize: 16,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 16).fontFamily,
  );

  static TextStyle label2 = TextStyle(
    fontSize: 14,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 14).fontFamily,
  );

  static TextStyle label3 = TextStyle(
    fontSize: 12,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w600, fontSize: 12).fontFamily,
  );

  static TextStyle body1 = TextStyle(
    fontSize: 16,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w400, fontSize: 16).fontFamily,
  );

  static TextStyle body2 = TextStyle(
    fontSize: 14,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w400, fontSize: 14).fontFamily,
  );

  static TextStyle body3 = TextStyle(
    fontSize: 12,
    fontFamily: GoogleFonts.prompt(fontWeight: FontWeight.w400, fontSize: 12).fontFamily,
  );

  static const TextStyle defaultTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle appBarTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Colors.black,
  );
  static const TextStyle headerTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 14,
  );
  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
}
