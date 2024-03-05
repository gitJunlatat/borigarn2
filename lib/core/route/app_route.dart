import 'package:borigarn/core/theme/app_annotated_region.dart';
import 'package:borigarn/feature/authen/login_screen.dart';
import 'package:borigarn/feature/booking/booking_screen.dart';
import 'package:borigarn/feature/home/home_screen.dart';
import 'package:borigarn/feature/inbox/inbox_screen.dart';
import 'package:borigarn/feature/profile/profile_screen.dart';
import 'package:borigarn/feature/tabbar/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_route.g.dart';


final rootNavigation = GlobalKey<NavigatorState>();

BuildContext? rootContext() {
  return rootNavigation.currentContext;
}

String currentPath() {
  final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
  final RouteMatchList matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : router.routerDelegate.currentConfiguration;
  final String location = matchList.uri.toString();
  return location;
}

@Riverpod(keepAlive: true, dependencies: [])
GoRouter goRouter(GoRouterRef ref) {
  return router;
}

final router = GoRouter(
  navigatorKey: rootNavigation,
  initialLocation: '/home',
  onException: (context, state, route) {
    route.go('/home');
  },
  // observers: [AppNavigatorObserver()],
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppAnnotatedRegion.light(
          child: TabBarScreen(navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
              routes: [

              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/booking',
              builder: (context, state) => const AppAnnotatedRegion.dark(child: BookingScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/inbox',
              builder: (context, state) => const AppAnnotatedRegion.dark(child: InboxScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: 'profile',
              path: '/profile',
              builder: (context, state) => const AppAnnotatedRegion.dark(child: ProfileScreen()),
              routes: [],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      parentNavigatorKey: rootNavigation,
      builder: (context, state) {
        return const AppAnnotatedRegion.dark(child: LoginScreen());
      },
      // routes: [
      //   GoRoute(
      //     name: 'auth-phone-number',
      //     path: 'phone-number',
      //     parentNavigatorKey: rootNavigation,
      //     builder: (context, state) {
      //       final type = (state.uri.queryParameters['type'] ?? "").getAuthenticationOtpType();
      //       return AuthenticationPreOtpScreen(authenticationOTPType: type);
      //     },
      //   ),
      //   GoRoute(
      //     name: 'auth-password-form',
      //     path: 'password-form',
      //     parentNavigatorKey: rootNavigation,
      //     builder: (context, state) {
      //       final type = state.extra as AuthenticationOTPType;
      //       return AuthenticationPasswordFormScreen(type: type);
      //     },
      //   ),
      //   GoRoute(
      //     name: 'auth-otp',
      //     path: 'otp',
      //     parentNavigatorKey: rootNavigation,
      //     builder: (context, state) {
      //       final data = state.extra as OtpScreenData;
      //       return OtpScreen(data: data);
      //     },
      //   ),
      //   GoRoute(
      //     name: 'forgot-password-success',
      //     path: 'forgot-success',
      //     parentNavigatorKey: rootNavigation,
      //     builder: (context, state) {
      //       return const SuccessScreen(type: SuccessScreenType.forgotPassword);
      //     },
      //   ),
      //   GoRoute(
      //     name: 'register-success',
      //     path: 'register-success',
      //     parentNavigatorKey: rootNavigation,
      //     builder: (context, state) {
      //       return const SuccessScreen(type: SuccessScreenType.register);
      //     },
      //   ),
      //   GoRoute(
      //     name: 'login-myorder',
      //     path: 'myorder',
      //     parentNavigatorKey: rootNavigation,
      //     builder: (context, state) {
      //       return const LoginByMyOrderScreen();
      //     },
      //   ),
      // ],
    ),

  ],
);
