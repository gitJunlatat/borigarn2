import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';

enum SettingMenuType {
  editProfile,
  paymentMethod,
  myPlace,
  language,
  invite,
  feedback,
  termAndCondition,
  privacy,
  paymentAndRefund,
  deleteUser,
  logout,
}

extension SettingMenuTypeExtension on SettingMenuType {
  String getTitle() {
    switch (this) {
      case SettingMenuType.editProfile:
        return "Edit Profile";
      case SettingMenuType.paymentMethod:
        return "Payment Method";
      case SettingMenuType.myPlace:
        return "My Place";
      case SettingMenuType.language:
        return "Language";
      case SettingMenuType.invite:
        return "Invite a Friend";
      case SettingMenuType.feedback:
        return "Application Feedback";
      case SettingMenuType.termAndCondition:
        return "Terms and Conditions";
      case SettingMenuType.privacy:
        return "Privacy Policy";
      case SettingMenuType.paymentAndRefund:
        return "Payment and Refund Policy";
      case SettingMenuType.deleteUser:
        return "Delete user account";
      case SettingMenuType.logout:
        return "Log out";
    }
  }

  Color getTextColor() {
    switch (this) {
      case SettingMenuType.deleteUser:
        return rootContext()!.appColors.error1;
      case SettingMenuType.logout:
        return rootContext()!.appColors.primary;
      default:
        return rootContext()!.appColors.title;
    }
  }

  SvgGenImage getIcon() {
    switch (this) {
      case SettingMenuType.editProfile:
        return MyAssets.profile.editIcon;
      case SettingMenuType.paymentMethod:
        return MyAssets.profile.creditCardIcon;
      case SettingMenuType.myPlace:
        return MyAssets.profile.mapIcon;
      case SettingMenuType.language:
        return MyAssets.profile.langIcon;
      case SettingMenuType.invite:
        return MyAssets.profile.addUserIcon;
      case SettingMenuType.feedback:
        return MyAssets.profile.commentIcon;
      case SettingMenuType.termAndCondition:
        return MyAssets.profile.questionIcon;
      case SettingMenuType.privacy:
        return MyAssets.profile.questionIcon;
      case SettingMenuType.paymentAndRefund:
        return MyAssets.profile.questionIcon;
      case SettingMenuType.deleteUser:
        return MyAssets.profile.questionIcon;
      case SettingMenuType.logout:
        return MyAssets.profile.logoutIcon;
    }
  }
}