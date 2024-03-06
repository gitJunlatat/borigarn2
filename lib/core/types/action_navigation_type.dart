import 'dart:ui';

import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import '../route/app_route.dart';

enum ActionNavigationType {
  ptsIcon, navigationBack, searchIcon, inactiveDelete, activeDelete, loading, booking
}

extension AppNavigationTypeExtension on ActionNavigationType {
  Widget getIcon() {
    switch (this) {
      case ActionNavigationType.ptsIcon:
      case ActionNavigationType.navigationBack:
      case ActionNavigationType.searchIcon:
        return MyAssets.navBack.svg(width: 26, height: 26);
      case ActionNavigationType.inactiveDelete:
        return Icon(Icons.delete_outlined, size: 26,
          color: colorFill(),
        );

      case ActionNavigationType.activeDelete:
        return Icon(Icons.delete_outlined, size: 26,
          color: colorFill(),
        );
      case ActionNavigationType.booking:
        return MyAssets.booking.calendarIcon.svg(width: 26, height: 26);
      default:
        final xxx = MyAssets.navBack.svg(width: 26, height: 26);
        return Icon(xxx as IconData?);

    }
  }

  ColorFilter? colorFilter() {
    switch (this) {
      case ActionNavigationType.inactiveDelete:
        return ColorFilter.mode(rootContext()!.appColors.disableText, BlendMode.srcIn);
      case ActionNavigationType.activeDelete:
        return ColorFilter.mode(rootContext()!.appColors.black, BlendMode.srcIn);
      default:
        return null;
    }
  }

  Color? colorFill() {
    switch (this) {
      case ActionNavigationType.inactiveDelete:
        return rootContext()!.appColors.disableText;
      case ActionNavigationType.activeDelete:
        return rootContext()!.appColors.black;
      default:
        return null;
    }
  }
}
