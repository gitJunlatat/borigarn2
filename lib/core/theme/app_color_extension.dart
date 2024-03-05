import 'package:flutter/material.dart';

import 'app_theme.dart';

extension ThemeGetter on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>() ?? AppTheme.lightAppColors;
}

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.primary,
    required this.subPrimary,
    required this.secondary,
    required this.subSecondary,
    required this.title,
    required this.subTitle,
    required this.secondaryText,
    required this.disableText,
    required this.border,
    required this.divider,
    required this.backgroundText,
    required this.error1,
    required this.error2,
    required this.inProgress1,
    required this.inProgress2,
    required this.success1,
    required this.success2,
    required this.warning1,
    required this.warning2,
    required this.orange1,
    required this.orange2,
    required this.buttonDefault,
    required this.btnHover,
    required this.btnDisable,
    required this.btnPress,
    required this.btnRelease,
    required this.textButtonOnLight,
    required this.textButtonOnDark,
    required this.light,
    required this.black,
    required this.n4,
    required this.n2,
    required this.n3,
    required this.n5,
    required this.lightPurple,
    required this.lightBlue,
    required this.purple,
    required this.lineAppColor,
    required this.fbAppColor,
    required this.darkBlue,
    required this.grey100,
    required this.grey150,
    required this.grey200,
    required this.grey300,
    required this.grey400,
    required this.grey500,
    required this.grey600,
    required this.grey700,
    required this.grey800,
  });

  final Color primary;
  final Color subPrimary;
  final Color secondary;
  final Color subSecondary;
  final Color title;
  final Color subTitle;
  final Color secondaryText;
  final Color disableText;
  final Color border;
  final Color divider;
  final Color backgroundText;
  final Color error1;
  final Color error2;
  final Color inProgress1;
  final Color inProgress2;
  final Color success1;
  final Color success2;
  final Color warning1;
  final Color warning2;
  final Color orange1;
  final Color orange2;
  final Color buttonDefault;
  final Color btnHover;
  final Color btnDisable;
  final Color btnPress;
  final Color btnRelease;
  final Color textButtonOnLight;
  final Color textButtonOnDark;
  final Color light;
  final Color black;
  final Color n4;
  final Color n2;
  final Color n3;
  final Color n5;
  final Color lightPurple;
  final Color lightBlue;
  final Color purple;
  final Color lineAppColor;
  final Color fbAppColor;
  final Color darkBlue;
  final Color grey100;
  final Color grey150;
  final Color grey200;
  final Color grey300;
  final Color grey400;
  final Color grey500;
  final Color grey600;
  final Color grey700;
  final Color grey800;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? subPrimary,
    Color? secondary,
    Color? subSecondary,
    Color? title,
    Color? subTitle,
    Color? secondaryText,
    Color? disableText,
    Color? border,
    Color? divider,
    Color? backgroundText,
    Color? error1,
    Color? error2,
    Color? inProgress1,
    Color? inProgress2,
    Color? success1,
    Color? success2,
    Color? warning1,
    Color? warning2,
    Color? orange1,
    Color? orange2,
    Color? buttonDefault,
    Color? btnHover,
    Color? btnDisable,
    Color? btnPress,
    Color? btnRelease,
    Color? textButtonOnLight,
    Color? textButtonOnDark,
    Color? light,
    Color? black,
    Color? n4,
    Color? n2,
    Color? n3,
    Color? n5,
    Color? lightPurple,
    Color? lightBlue,
    Color? purple,
    Color? lineAppColor,
    Color? fbAppColor,
    Color? darkBlue,
    Color? grey100,
    Color? grey150,
    Color? grey200,
    Color? grey300,
    Color? grey400,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      subPrimary: subPrimary ?? this.subPrimary,
      secondary: secondary ?? this.secondary,
      subSecondary: subSecondary ?? this.subSecondary,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      secondaryText: secondaryText ?? this.secondaryText,
      disableText: disableText ?? this.disableText,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      backgroundText: backgroundText ?? this.backgroundText,
      error1: error1 ?? this.error1,
      error2: error2 ?? this.error2,
      inProgress1: inProgress1 ?? this.inProgress1,
      inProgress2: inProgress2 ?? this.inProgress2,
      success1: success1 ?? this.success1,
      success2: success2 ?? this.success2,
      warning1: warning1 ?? this.warning1,
      warning2: warning2 ?? this.warning2,
      orange1: orange1 ?? this.orange1,
      orange2: orange2 ?? this.orange2,
      buttonDefault: buttonDefault ?? this.buttonDefault,
      btnHover: btnHover ?? this.btnHover,
      btnDisable: btnDisable ?? this.btnDisable,
      btnPress: btnPress ?? this.btnPress,
      btnRelease: btnRelease ?? this.btnRelease,
      textButtonOnLight: textButtonOnLight ?? this.textButtonOnLight,
      textButtonOnDark: textButtonOnDark ?? this.textButtonOnDark,
      light: light ?? this.light,
      black: black ?? this.black,
      n4: n4 ?? this.n4,
      n2: n2 ?? this.n2,
      n3: n3 ?? this.n3,
      n5: n5 ?? this.n5,
      lightPurple: lightPurple ?? this.lightPurple,
      lightBlue: lightBlue ?? this.lightBlue,
      purple: purple ?? this.purple,
      lineAppColor: lineAppColor ?? this.lineAppColor,
      fbAppColor: fbAppColor ?? this.fbAppColor,
      darkBlue: darkBlue ?? this.darkBlue,
      grey100: grey100 ?? this.grey100,
      grey150: grey150 ?? this.grey150,
      grey200: grey200 ?? this.grey200,
      grey300: grey300 ?? this.grey300,
      grey400: grey400 ?? this.grey400,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      subPrimary: Color.lerp(subPrimary, other.subPrimary, t) ?? subPrimary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      subSecondary: Color.lerp(subSecondary, other.subSecondary, t) ?? subSecondary,
      title: Color.lerp(title, other.title, t) ?? title,
      subTitle: Color.lerp(subTitle, other.subTitle, t) ?? subTitle,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t) ?? secondaryText,
      disableText: Color.lerp(disableText, other.disableText, t) ?? disableText,
      border: Color.lerp(border, other.border, t) ?? border,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      backgroundText: Color.lerp(backgroundText, other.backgroundText, t) ?? backgroundText,
      error1: Color.lerp(error1, other.error1, t) ?? error1,
      error2: Color.lerp(error2, other.error2, t) ?? error2,
      inProgress1: Color.lerp(inProgress1, other.inProgress1, t) ?? inProgress1,
      inProgress2: Color.lerp(inProgress2, other.inProgress2, t) ?? inProgress2,
      success1: Color.lerp(success1, other.success1, t) ?? success1,
      success2: Color.lerp(success2, other.success2, t) ?? success2,
      warning1: Color.lerp(warning1, other.warning1, t) ?? warning1,
      warning2: Color.lerp(warning2, other.warning2, t) ?? warning2,
      orange1: Color.lerp(orange1, other.orange1, t) ?? orange1,
      orange2: Color.lerp(orange2, other.orange2, t) ?? orange2,
      buttonDefault: Color.lerp(buttonDefault, other.buttonDefault, t) ?? buttonDefault,
      btnHover: Color.lerp(btnHover, other.btnHover, t) ?? btnHover,
      btnDisable: Color.lerp(btnDisable, other.btnDisable, t) ?? btnDisable,
      btnPress: Color.lerp(btnPress, other.btnPress, t) ?? btnPress,
      btnRelease: Color.lerp(btnRelease, other.btnRelease, t) ?? btnRelease,
      textButtonOnLight: Color.lerp(textButtonOnLight, other.textButtonOnLight, t) ?? textButtonOnLight,
      textButtonOnDark: Color.lerp(textButtonOnDark, other.textButtonOnDark, t) ?? textButtonOnDark,
      light: Color.lerp(light, other.light, t) ?? light,
      black: Color.lerp(black, other.black, t) ?? black,
      n4: Color.lerp(n4, other.n4, t) ?? n4,
      n2: Color.lerp(n2, other.n2, t) ?? n2,
      n3: Color.lerp(n3, other.n3, t) ?? n3,
      n5: Color.lerp(n5, other.n5, t) ?? n5,
      lightPurple: Color.lerp(lightPurple, other.lightPurple, t) ?? lightPurple,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t) ?? lightBlue,
      purple: Color.lerp(purple, other.purple, t) ?? purple,
      lineAppColor: Color.lerp(lineAppColor, other.lineAppColor, t) ?? lineAppColor,
      fbAppColor: Color.lerp(fbAppColor, other.fbAppColor, t) ?? fbAppColor,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t) ?? darkBlue,
      grey100: Color.lerp(grey100, other.grey100, t) ?? grey100,
      grey150: Color.lerp(grey150, other.grey150, t) ?? grey150,
      grey200: Color.lerp(grey200, other.grey200, t) ?? grey200,
      grey300: Color.lerp(grey300, other.grey300, t) ?? grey300,
      grey400: Color.lerp(grey400, other.grey400, t) ?? grey400,
      grey500: Color.lerp(grey500, other.grey500, t) ?? grey500,
      grey600: Color.lerp(grey600, other.grey600, t) ?? grey600,
      grey700: Color.lerp(grey700, other.grey700, t) ?? grey700,
      grey800: Color.lerp(grey800, other.grey800, t) ?? grey800,
    );
  }
}
