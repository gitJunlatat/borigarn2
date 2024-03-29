import 'package:borigarn/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';

enum EditFormType {
  name,
  phoneNumber,
  email,
  password,
  confirmPassword;

  String get title {
    switch(this) {
      case EditFormType.name:
        return 'yourName'.tr();
      case EditFormType.phoneNumber:
        return 'phoneNumber'.tr();
      case EditFormType.email:
        return 'email'.tr();
      case EditFormType.password:
        return 'password'.tr();
      case EditFormType.confirmPassword:
        return 'confirmPassword'.tr();
    }
  }

  SvgGenImage get icon {
    switch(this) {
      case EditFormType.name:
        return MyAssets.iconUser;
      case EditFormType.phoneNumber:
        return MyAssets.iconPhone;
      case EditFormType.email:
        return MyAssets.iconMail;
      case EditFormType.password:
      case EditFormType.confirmPassword:
        return MyAssets.keyIcon;
    }
  }
}