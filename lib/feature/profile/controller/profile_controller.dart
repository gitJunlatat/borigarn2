
import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/datasource/location_datasource.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/utils/error.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/feature/home/state/get_user.dart';
import 'package:borigarn/feature/home/types/app_button_dialog_type.dart';
import 'package:borigarn/feature/home/widgets/confirm_dialog.dart';
import 'package:borigarn/feature/location/models/payload/select_location.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
ProfileController profileController(ProfileControllerRef ref) {
  return ProfileController(ref);
}

class ProfileController {
  final ProviderRef ref;


  ProfileController(this.ref);



  Future<void> saveProfile(String name, String email) async {
      if(name.isEmpty) {
        //todo กรุณาระบุชื่อผู้ใช้งาน
        AppToast.failed(message: "Please enter your name.");
        return;
      }

      if(email.isEmpty) {
        //todo กรุณาระบุอีเมล
        AppToast.failed(message: "Please enter your email.");
        return;
      }
      EasyLoading.show();
      try {
        final result = await ref.watch(authenDatasourceProvider).updateUser(name, email);
        //todo อัพเดทโปรไฟล์สำเร็จแล้ว
        AppToast.success(message: "Profile updated successfully.");
        ref.invalidate(getUserProvider);
        EasyLoading.dismiss();
        ref.read(goRouterProvider).pop();
      }catch(e) {
        //todo อัพเดทโปรไฟล์ไม่สำเร็จ
        AppToast.failed(message: "Profile update unsuccessful.");
        EasyLoading.dismiss();
      }
  }

  Future<void> deleteAccount() async {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.48),
      context: rootContext()!,
      builder: (context) {
        return AppConfirmDialog(
          title: context.tr(LocaleKeys.deleteAccountWording),
          message: '',
          buttons: const [AppButtonDialogType.cancel, AppButtonDialogType.ok],
          onPressed: (buttonType) {

          },
        );
      },
    );
  }


  Future<void> logout() async {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.48),
      context: rootContext()!,
      builder: (context) {
        return AppConfirmDialog(
          title: context.tr(LocaleKeys.confirmLogout),
          message: '',
          buttons: const [AppButtonDialogType.cancel, AppButtonDialogType.ok],
          onPressed: (buttonType) {

          },
        );
      },
    );
  }

}
