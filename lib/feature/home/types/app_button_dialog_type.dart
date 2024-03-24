import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum AppButtonDialogType {
  cancel,
  basketRemove,
  ok,
  gotIt,
}

extension AppDialogTypeExtension on AppButtonDialogType {
  String title() {
    switch (this) {
      case AppButtonDialogType.cancel:
        return "ยกเลิก";
      case AppButtonDialogType.basketRemove:
        return "นำออก";
      case AppButtonDialogType.ok:
        return "ตกลง";
      case AppButtonDialogType.gotIt:
        return "รับทราบ";
    }
  }

  Color? foregroundColor() {
    switch (this) {
      case AppButtonDialogType.cancel:
        return Colors.black;
      case AppButtonDialogType.basketRemove:
        return Colors.white;
      case AppButtonDialogType.ok:
      case AppButtonDialogType.gotIt:
        return Colors.white;
    }
  }

  Color? backgroundColor() {
    switch (this) {
      case AppButtonDialogType.cancel:
        return rootContext()!.appColors.n5;
      case AppButtonDialogType.basketRemove:
        return rootContext()!.appColors.error1;
      case AppButtonDialogType.ok:
      case AppButtonDialogType.gotIt:
      return rootContext()!.appColors.primary;
    }
  }

  Color? borderColor() {
    switch (this) {
      case AppButtonDialogType.cancel:
        return rootContext()!.appColors.n5;
      case AppButtonDialogType.basketRemove:
        return rootContext()!.appColors.error1;
      case AppButtonDialogType.ok:
      case AppButtonDialogType.gotIt:
      return rootContext()!.appColors.primary;
    }
  }
}
