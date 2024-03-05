import 'package:borigarn/core/constant/constants.dart';
import 'package:borigarn/core/prefs/shared_prefs.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
  (ref) {
    final storage = ref.watch(storageServiceProvider);
    return AppThemeModeNotifier(storage);
  },
);

class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
  final StorageService stroageService;

  ThemeMode currentTheme = ThemeMode.light;

  AppThemeModeNotifier(this.stroageService) : super(ThemeMode.light) {
    getCurrentTheme();
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    stroageService.set(APP_THEME_STORAGE_KEY, state.name);
  }

  void getCurrentTheme() async {
    final theme = await stroageService.get(APP_THEME_STORAGE_KEY);
    final value = ThemeMode.values.byName('${theme ?? 'light'}');
    state = value;
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: TextThemes.darkTextTheme,
        primaryTextTheme: TextThemes.primaryTextTheme,
        splashFactory: NoSplash.splashFactory,
        extensions: [
          lightAppColors,
        ],);
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      splashFactory: NoSplash.splashFactory,
      extensions: [
        darkAppColors,
      ],
      // ),
    );
  }

  static final lightAppColors = AppColorsExtension(
    primary: const Color(0xFF009ACD),
    subPrimary: const Color(0xFF5FBDED),
    secondary: const Color(0xFF4E54A3),
    subSecondary: const Color(0xFF8387BF),
    title: const Color(0xFF000000),
    subTitle: const Color(0xFF7B7873),
    secondaryText: const Color(0xFFBCBAB7),
    disableText: const Color(0xFFDCDBD9),
    border: const Color(0xFFECECEC),
    divider: const Color(0xFFF5F5F5),
    backgroundText: const Color(0xFFF5F8F9),
    error1: const Color(0xFFE14942),
    error2: const Color(0xFFF6736D),
    inProgress1: const Color(0xFF008DFF),
    inProgress2: const Color(0xFFABDCF5),
    success1: const Color(0xFF43C58E),
    success2: const Color(0xFFA4FCE6),
    warning1: const Color(0xFFFFC130),
    warning2: const Color(0xFFFFDA83),
    orange1: const Color(0xFFFA8C16),
    orange2: const Color(0xFFFFA940),
    buttonDefault: const Color(0xFF009ACD),
    btnHover: const Color(0xFF5FBDED),
    btnDisable: const Color(0xFFD9D9D9),
    btnPress: const Color(0xFF007BA4),
    btnRelease: const Color(0xFF005C7B),
    textButtonOnLight: const Color(0xFF009ACD),
    textButtonOnDark: const Color(0xFFFFFFFF),
    light: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    n4: const Color(0xFFF0F0F0),
    n2: const Color(0xFFFAFAFA),
    n3: const Color(0xFFF5F5F5),
    n5: const Color(0xFFD9D9D9),
    lightPurple: const Color(0xFF974AFF),
    lightBlue: const Color(0xFF00B0FF),
    purple: const Color(0xFF6A3AD1),
    lineAppColor: const Color(0xFF06C755),
    fbAppColor: const Color(0xFF1877F2),
    darkBlue: const Color(0xFF2F3C4E),
    grey100: const Color(0xFFFCFCFB),
    grey150: const Color(0xFFECECEC),
    grey200: const Color(0xFFDCDBD9),
    grey300: const Color(0xFFBCBAB7),
    grey400: const Color(0xFF9C9995),
    grey500: const Color(0xFF7B7873),
    grey600: const Color(0xFF565450),
    grey700: const Color(0xFF31302E),
    grey800: const Color(0xFF0C0C0B),
  );

  static final darkAppColors = AppColorsExtension(
    primary: const Color(0xFF009ACD),
    subPrimary: const Color(0xFF5FBDED),
    secondary: const Color(0xFF4E54A3),
    subSecondary: const Color(0xFF8387BF),
    title: const Color(0xFF000000),
    subTitle: const Color(0xFF7B7873),
    secondaryText: const Color(0xFFBCBAB7),
    disableText: const Color(0xFFDCDBD9),
    border: const Color(0xFFECECEC),
    divider: const Color(0xFFF5F5F5),
    backgroundText: const Color(0xFFF5F8F9),
    error1: const Color(0xFFE14942),
    error2: const Color(0xFFF6736D),
    inProgress1: const Color(0xFF008DFF),
    inProgress2: const Color(0xFFABDCF5),
    success1: const Color(0xFF43C58E),
    success2: const Color(0xFFA4FCE6),
    warning1: const Color(0xFFFFC130),
    warning2: const Color(0xFFFFDA83),
    orange1: const Color(0xFFFA8C16),
    orange2: const Color(0xFFFFA940),
    buttonDefault: const Color(0xFF009ACD),
    btnHover: const Color(0xFF5FBDED),
    btnDisable: const Color(0xFFD9D9D9),
    btnPress: const Color(0xFF007BA4),
    btnRelease: const Color(0xFF005C7B),
    textButtonOnLight: const Color(0xFF009ACD),
    textButtonOnDark: const Color(0xFFFFFFFF),
    light: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    n4: const Color(0xFFF0F0F0),
    n2: const Color(0xFFFAFAFA),
    n3: const Color(0xFFF5F5F5),
    n5: const Color(0xFFD9D9D9),
    lightPurple: const Color(0xFF974AFF),
    lightBlue: const Color(0xFF00B0FF),
    purple: const Color(0xFF6A3AD1),
    lineAppColor: const Color(0xFF06C755),
    fbAppColor: const Color(0xFF1877F2),
    darkBlue: const Color(0xFF2F3C4E),
    grey100: const Color(0xFFFCFCFB),
    grey150: const Color(0xFFECECEC),
    grey200: const Color(0xFFDCDBD9),
    grey300: const Color(0xFFBCBAB7),
    grey400: const Color(0xFF9C9995),
    grey500: const Color(0xFF7B7873),
    grey600: const Color(0xFF565450),
    grey700: const Color(0xFF31302E),
    grey800: const Color(0xFF0C0C0B),
  );

}
