import 'dart:async';
import 'dart:io';

import 'package:borigarn/core/manager/network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/prefs/prefs.dart';
import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';
import 'global/generated/codegen_loader.g.dart';

void main() {
  mainCommon();
  // runApp(const MyApp());
}

FutureOr<void> mainCommon() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FlutterNativeSplash.remove();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB_6-ymDRytfzRl3-F31O31MdIEItehG7s",
            appId: "app-1-743558194050-ios-7c725fced4a7f9ed9d659b",
            messagingSenderId: "743558194050",
            projectId: "borigarn-8c247"));
  } else {
    // await Firebase.initializeApp();
  }

  await SharedPrefs().init();
  // try {
  //   // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // } catch (e){
  //   print("firebase authemulator error at e");
  //   print(e);
  // }

  if(Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localHost';
  // await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);

  runApp(
     ProviderScope(
      // observers: [Observers()],
      child: EasyLocalization(
        supportedLocales: const [Locale('th'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('th'),
          assetLoader: const CodegenLoader(),


          child: const KeyboardDismissOnTap(
          child: MyApp(),
        ),
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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


// getCurrentLocation() async {
//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//
//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {//check if thelocation service was enable or not
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       return;
//     }
//   }
//
//   permissionGranted = await location.hasPermission();
//   if (permissionGranted == PermissionStatus.denied) {
//     permissionGranted = await location.requestPermission();
// //if the location was denied it will ask next time the user enter the screen
//     if (permissionGranted != PermissionStatus.granted) {
// //in case of denied you can add any thing here like error message or something else
//       return;
//     }
//   }
//
//   LocationData currentPosition = await location.getLocation();
//   latitude = currentPosition.latitude!;
//   longitude = currentPosition.longitude!;
//   final marker = Marker(
//     markerId: const MarkerId('myLocation'),
//     position: LatLng(latitude, longitude),
//     infoWindow: const InfoWindow(
//       title: 'you can add any message here',
//     ),
//   );
//   setState(() {
//     _markers['myLocation'] = marker;
//     _controller?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
//       ),
//     );
//   });
// }