import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum LoginFormType {
  username,
  password,
}

extension RawData on LoginFormType {
  String getTextFieldName() {
    switch (this) {
      case LoginFormType.username:
        return rootContext()!.tr(LocaleKeys.email);
      case LoginFormType.password:
        return rootContext()!.tr(LocaleKeys.password);
    }
  }

  String getHintTextFieldName() {
    switch (this) {
      case LoginFormType.username:
        return rootContext()!.tr(LocaleKeys.email);
      case LoginFormType.password:
        return rootContext()!.tr(LocaleKeys.password);
    }
  }
}

