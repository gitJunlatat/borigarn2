import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
        return LocaleKeys.editProfile.tr();
      case SettingMenuType.paymentMethod:
        return LocaleKeys.paymentMethod.tr();
      case SettingMenuType.myPlace:
        return LocaleKeys.myPlace.tr();
      case SettingMenuType.language:
        return LocaleKeys.language.tr();
      case SettingMenuType.invite:
        return LocaleKeys.inviteFriend.tr();
      case SettingMenuType.feedback:
        return LocaleKeys.feedback.tr();
      case SettingMenuType.termAndCondition:
        return LocaleKeys.termAndConditions.tr();
      case SettingMenuType.privacy:
        return LocaleKeys.privacyPolicy.tr();
      case SettingMenuType.paymentAndRefund:
        return LocaleKeys.paymentAndRefund.tr();
      case SettingMenuType.deleteUser:
        return LocaleKeys.deleteUserAccount.tr();
      case SettingMenuType.logout:
        return LocaleKeys.logout.tr();
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
        return MyAssets.deleteIcon;
      case SettingMenuType.logout:
        return MyAssets.profile.logoutIcon;
    }
  }
}