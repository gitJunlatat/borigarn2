import 'package:borigarn/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';

enum EditFormType {
  name,
  phoneNumber,
  email;

  String get title {
    switch(this) {
      case EditFormType.name:
        return 'yourName'.tr();
      case EditFormType.phoneNumber:
        return 'phoneNumber'.tr();
      case EditFormType.email:
        return 'email'.tr();
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

    }
  }
}