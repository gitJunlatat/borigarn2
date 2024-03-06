import 'package:borigarn/core/theme/app_annotated_region.dart';
import 'package:borigarn/feature/authen/login_screen.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/booking/views/booking_detail_screen.dart';
import 'package:borigarn/feature/booking/views/booking_screen.dart';
import 'package:borigarn/feature/booking/views/review_screen.dart';
import 'package:borigarn/feature/home/home_screen.dart';
import 'package:borigarn/feature/inbox/inbox_screen.dart';
import 'package:borigarn/feature/profile/profile_screen.dart';
import 'package:borigarn/feature/tabbar/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../feature/booking/views/review_success_screen.dart';

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
              builder: (context, state) => const AppAnnotatedRegion.dark(child: HomeScreen()),
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
              routes: [
                GoRoute(
                  name: 'booking_detail',
                  path: 'booking_detail',
                  parentNavigatorKey: rootNavigation,
                  builder: (context, state) {
                    final model = state.extra as BookingModel;
                    return BookingDetailScreen(model: model);
                  },
                ),
                GoRoute(
                  name: 'review',
                  path: 'review',
                  parentNavigatorKey: rootNavigation,
                  builder: (context, state) {
                    return const ReviewScreen();
                  },
                ),

                GoRoute(
                  name: 'review_success',
                  path: 'review_success',
                  parentNavigatorKey: rootNavigation,
                  builder: (context, state) {
                    final rating = state.extra as double;
                    return  ReviewSuccessScreen(rating: rating);
                  },
                ),

              ]
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
