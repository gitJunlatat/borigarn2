import 'package:borigarn/core/theme/app_annotated_region.dart';
import 'package:borigarn/feature/authen/models/request_otp_model.dart';
import 'package:borigarn/feature/authen/models/verify_otp_model.dart';
import 'package:borigarn/feature/authen/models/payload/verify_otp_payload.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/authen/views/login_screen.dart';
import 'package:borigarn/feature/authen/views/request_otp_screen.dart';
import 'package:borigarn/feature/authen/views/reset_password_screen.dart';
import 'package:borigarn/feature/authen/views/verify_otp_screen.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/booking/views/booking_detail_screen.dart';
import 'package:borigarn/feature/booking/views/booking_screen.dart';
import 'package:borigarn/feature/booking/views/review_screen.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/types/service_type.dart';
import 'package:borigarn/feature/home/views/create_booking_screen.dart';
import 'package:borigarn/feature/home/views/home_screen.dart';
import 'package:borigarn/feature/inbox/inbox_screen.dart';
import 'package:borigarn/feature/location/edit_location_screen.dart';
import 'package:borigarn/feature/location/location_screen.dart';
import 'package:borigarn/feature/profile/edit_profile_screen.dart';
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
                GoRoute(
                  name: 'create_booking',
                  path: 'create_booking',
                  parentNavigatorKey: rootNavigation,
                  builder: (context, state) {
                    final model = state.extra as Service;
                    return CreateBookingScreen(model: model);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(path: '/booking', builder: (context, state) => const AppAnnotatedRegion.dark(child: BookingScreen()), routes: [
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
                  return ReviewSuccessScreen(rating: rating);
                },
              ),
            ]),
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
      routes: [
        GoRoute(
          name: 'request_otp',
          path: 'request_otp',
          parentNavigatorKey: rootNavigation,
          builder: (context, state) {
            return RequestOtpScreen(
              otpFlowType: state.extra as AuthenticationOTPType,
            );
          },
        ),
        GoRoute(
          name: 'verify_otp',
          path: 'verify_otp',
          parentNavigatorKey: rootNavigation,
          builder: (context, state) {
            final (model, otpFlowType) = state.extra as (RequestOTPModel, AuthenticationOTPType);
            return VerifyOtpScreen(
              model: model,
              otpFlowType: otpFlowType,
            );
          },
        ),
        GoRoute(
          name: 'reset_password',
          path: 'reset_password',
          parentNavigatorKey: rootNavigation,
          builder: (context, state) {
            final (model, otpFlowType) = state.extra as (VerifyOTPModel, AuthenticationOTPType);
            return ResetPasswordScreen(
              model: model,
              otpType: otpFlowType,
            );
          },
        )
      ],
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

    GoRoute(
      name: 'edit_profile_screen',
      path: '/edit_profile_screen',
      parentNavigatorKey: rootNavigation,
      builder: (context, state) {
        return const AppAnnotatedRegion.dark(child: EditProfileScreen());

      },
      routes: [

      ],
    ),

    GoRoute(
      name: 'location',
      path: '/location',
      parentNavigatorKey: rootNavigation,
      builder: (context, state) {
        return const AppAnnotatedRegion.dark(child: LocationScreen());

      },
      routes: [
        GoRoute(
          name: 'edit_location',
          path: 'edit_location',
          parentNavigatorKey: rootNavigation,
          builder: (context, state) {
            return const AppAnnotatedRegion.dark(child: EditLocationScreen());
          },
          routes: [

          ],
        )

      ],
    ),
  ],
);

extension GoRouterExtension on GoRouter {
  void popUntilPath(String routePath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation != routePath) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }
}
