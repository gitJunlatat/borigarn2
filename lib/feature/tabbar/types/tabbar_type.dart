
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/feature/booking/booking_screen.dart';
import 'package:borigarn/feature/home/home_screen.dart';
import 'package:borigarn/feature/inbox/inbox_screen.dart';
import 'package:borigarn/feature/profile/profile_screen.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum TabBarType { home, booking, inbox, profile }

extension TabBarTypeExtension on TabBarType {
  String getName() {
    switch (this) {
      case TabBarType.home:
        return 'home';
      case TabBarType.booking:
        return 'booking';
      case TabBarType.inbox:
        return 'inbox';
      case TabBarType.profile:
        return 'profile';
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

    // if (!isIgnoreColorFill()) {
    //   colorFilter = ColorFilter.mode(isCurrentIndex ? rootContext()!.appColors.primary : rootContext()!.appColors.grey500, BlendMode.srcIn);
    //   color = isCurrentIndex ? rootContext()!.appColors.primary : rootContext()!.appColors.grey500;
    // }
    switch (this) {
      case TabBarType.home:
        return MyAssets.home.svg(
          height: 24,
          colorFilter: colorFilter,
        );
      case TabBarType.booking:
        return MyAssets.booking.svg(
          height: 24,
          colorFilter: colorFilter,
        );
      case TabBarType.inbox:
        return Icon(
          Icons.shopping_basket_outlined,
          size: 24,
          color: color,
        );
      case TabBarType.profile:
        return MyAssets.profile.svg(
          height: 24,
          colorFilter: colorFilter,
        );
    }
  }

  // bool isIgnoreColorFill() {
  //   switch (this) {
  //       return false;
  //   }
  // }

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


  // Key getKey() {
  //   switch (this) {
  //     case TabBarType.home:
  //       return WidgetKeys.homeTabBar;
  //     case TabBarType.pinToShare:
  //       return WidgetKeys.pinToShareTabBar;
  //     case TabBarType.cart:
  //       return WidgetKeys.cartTabBar;
  //     case TabBarType.profile:
  //       return WidgetKeys.profileTabBar;
  //   }
  // }
}
