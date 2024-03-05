import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_text_style.dart';

class TextThemes {
  /// Main text theme

  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.h1.copyWith(color: Colors.black, letterSpacing: 0), //h1
      displayMedium: AppTextStyles.h2.copyWith(color: Colors.black, letterSpacing: 0), //h2
      displaySmall: AppTextStyles.h3.copyWith(color: Colors.black, letterSpacing: 0), //h3
      headlineMedium: AppTextStyles.h4.copyWith(color: Colors.black, letterSpacing: 0), //h4

      titleMedium: AppTextStyles.subtitle.copyWith(color: Colors.black, letterSpacing: 0), //subtitle

      labelLarge: AppTextStyles.label1.copyWith(color: Colors.black, letterSpacing: 0), //label 1
      labelMedium: AppTextStyles.label2.copyWith(color: Colors.black, letterSpacing: 0), //label 2
      labelSmall: AppTextStyles.label3.copyWith(color: Colors.black, letterSpacing: 0), //label 3

      bodyLarge: AppTextStyles.body1.copyWith(color: Colors.black, letterSpacing: 0), //body 1
      bodyMedium: AppTextStyles.body2.copyWith(color: Colors.black, letterSpacing: 0), //body 2
      bodySmall: AppTextStyles.body3.copyWith(color: Colors.black, letterSpacing: 0), //body 3
    );
  }

  /// Dark text theme
  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: AppTextStyles.h1.copyWith(color: Colors.white, letterSpacing: 0), //h1
      displayMedium: AppTextStyles.h2.copyWith(color: Colors.white, letterSpacing: 0), //h2
      displaySmall: AppTextStyles.h3.copyWith(color: Colors.white, letterSpacing: 0), //h3
      headlineMedium: AppTextStyles.h4.copyWith(color: Colors.white, letterSpacing: 0), //h4

      titleMedium: AppTextStyles.subtitle.copyWith(color: Colors.white, letterSpacing: 0), //subtitle

      labelLarge: AppTextStyles.label1.copyWith(color: Colors.white, letterSpacing: 0), //label 1
      labelMedium: AppTextStyles.label2.copyWith(color: Colors.white, letterSpacing: 0), //label 2
      labelSmall: AppTextStyles.label3.copyWith(color: Colors.white, letterSpacing: 0), //label 3

      bodyLarge: AppTextStyles.body1.copyWith(color: Colors.white, letterSpacing: 0), //body 1
      bodyMedium: AppTextStyles.body2.copyWith(color: Colors.white, letterSpacing: 0), //body 2
      bodySmall: AppTextStyles.body3.copyWith(color: Colors.white, letterSpacing: 0), //body 3
    );
  }

  /// Primary text theme
  static TextTheme get primaryTextTheme {
    return TextTheme(
      displayLarge: AppTextStyles.h1.copyWith(color: Colors.black, letterSpacing: 0), //h1
      displayMedium: AppTextStyles.h2.copyWith(color: Colors.black, letterSpacing: 0), //h2
      displaySmall: AppTextStyles.h3.copyWith(color: Colors.black, letterSpacing: 0), //h3
      headlineMedium: AppTextStyles.h4.copyWith(color: Colors.black, letterSpacing: 0), //h4

      titleMedium: AppTextStyles.subtitle.copyWith(color: Colors.black, letterSpacing: 0), //subtitle

      labelLarge: AppTextStyles.label1.copyWith(color: Colors.black, letterSpacing: 0), //label 1
      labelMedium: AppTextStyles.label2.copyWith(color: Colors.black, letterSpacing: 0), //label 2
      labelSmall: AppTextStyles.label3.copyWith(color: Colors.black, letterSpacing: 0), //label 3

      bodyLarge: AppTextStyles.body1.copyWith(color: Colors.black, letterSpacing: 0), //body 1
      bodyMedium: AppTextStyles.body2.copyWith(color: Colors.black, letterSpacing: 0), //body 2
      bodySmall: AppTextStyles.body3.copyWith(color: Colors.black, letterSpacing: 0), //body 3
    );
  }
}

extension textThemeExtension on TextTheme {
  TextStyle hint({
    double height = 1,
    double fontSize = 10,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.lato().fontFamily,
      height: height,
    );
  }

  TextStyle hintBold() {
    return TextStyle(
      fontSize: 10,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }

  // TextStyle hint() {
  //   return TextStyle(
  //     fontSize: 10,
  //     color: Colors.black,
  //     fontWeight: FontWeight.w400,
  //     fontFamily: GoogleFonts
  //         .lato()
  //         .fontFamily,
  //     height: 1,
  //   );
  // }
}
