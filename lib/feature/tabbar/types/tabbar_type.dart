
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/feature/booking/views/booking_screen.dart';
import 'package:borigarn/feature/home/views/home_screen.dart';
import 'package:borigarn/feature/inbox/inbox_screen.dart';
import 'package:borigarn/feature/profile/profile_screen.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum TabBarType { home, booking, inbox, profile }

extension TabBarTypeExtension on TabBarType {
  String getName() {
    switch (this) {
      case TabBarType.home:
        return LocaleKeys.home;
      case TabBarType.booking:
        return LocaleKeys.bookings;
      case TabBarType.inbox:
        return LocaleKeys.inbox;
      case TabBarType.profile:
        return LocaleKeys.profile;
    }
  }

  String getSemanticsLabel() {
    switch (this) {
      case TabBarType.home:
        return "tab-home-icon";
      case TabBarType.booking:
        return "tab-pts-icon";
      case TabBarType.inbox:
        return "tab-cart-icon";
      case TabBarType.profile:
        return "tab-profile-icon";
    }
  }

  Widget getIcon(bool isCurrentIndex) {
    ColorFilter? colorFilter;
    Color? color;
    colorFilter = ColorFilter.mode(isCurrentIndex ? rootContext()!.appColors.primary : rootContext()!.appColors.grey500, BlendMode.srcIn);
    color = isCurrentIndex ? rootContext()!.appColors.primary : rootContext()!.appColors.grey500;

    switch (this) {
      case TabBarType.home:
        return MyAssets.homeIcon.svg(
          height: 24,
          colorFilter: colorFilter,
        );
      case TabBarType.booking:
        return MyAssets.bookingIcon.svg(
          height: 24,
          colorFilter: colorFilter,
        );
      case TabBarType.inbox:
        return MyAssets.inboxIcon.svg(
          height: 24,
          colorFilter: colorFilter,
        );
      case TabBarType.profile:
        return MyAssets.profileIcon.svg(
          height: 24,
          colorFilter: colorFilter,
        );
    }
  }

  Widget getScreen() {
    switch (this) {
      case TabBarType.home:
        return const HomeScreen();
      case TabBarType.booking:
        return const BookingScreen();
      case TabBarType.inbox:
        return const InboxScreen();
      case TabBarType.profile:
        return const ProfileScreen();
    }
  }
}
