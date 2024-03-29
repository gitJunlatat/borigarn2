import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/theme/app_theme.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum AppButtonDialogType {
  cancel,
  basketRemove,
  ok,
  gotIt,
  gotoLogin
}

extension AppDialogTypeExtension on AppButtonDialogType {
  String title() {
    switch (this) {
      case AppButtonDialogType.cancel:
        return rootContext()!.tr(LocaleKeys.cancelButton);
      case AppButtonDialogType.basketRemove:
        return rootContext()!.tr(LocaleKeys.cancelButton);
      case AppButtonDialogType.ok:
        return rootContext()!.tr(LocaleKeys.okButton);
      case AppButtonDialogType.gotIt:
        return rootContext()!.tr(LocaleKeys.okButton);
      case AppButtonDialogType.gotoLogin:
        return rootContext()!.tr(LocaleKeys.gotoLogin);
    }
  }

  Color? foregroundColor() {
    switch (this) {
      case AppButtonDialogType.cancel:
        return Colors.black;
      case AppButtonDialogType.basketRemove:
        return Colors.white;
      case AppButtonDialogType.ok:
      case AppButtonDialogType.gotoLogin:

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
      case AppButtonDialogType.gotoLogin:
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
      case AppButtonDialogType.gotoLogin:
        return rootContext()!.appColors.primary;
    }
  }
}
