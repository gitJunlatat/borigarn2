import 'dart:async';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/prefs/prefs.dart';
import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';

void main() {
  mainCommon();
  // runApp(const MyApp());
}

FutureOr<void> mainCommon() async {

  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await SharedPrefs().init();

  runApp(
    const ProviderScope(
      // observers: [Observers()],
      child: KeyboardDismissOnTap(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_,child) {
        return MaterialApp.router(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          builder: EasyLoading.init(builder: (BuildContext context, Widget? child) {
            final mediaQuery = MediaQuery.of(context);

            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1)),
              child: child!,
            );
          }),
          routerDelegate: ref.read(goRouterProvider).routerDelegate,
          routeInformationProvider: ref.read(goRouterProvider).routeInformationProvider,
          routeInformationParser: ref.read(goRouterProvider).routeInformationParser,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
