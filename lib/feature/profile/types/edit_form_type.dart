import 'package:borigarn/gen/assets.gen.dart';

enum EditFormType {
  name,
  phoneNumber,
  email;

  String get title {
    switch(this) {
      case EditFormType.name:
        return 'Your name';
      case EditFormType.phoneNumber:
        return 'Phone number';
      case EditFormType.email:
        return 'Email';
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