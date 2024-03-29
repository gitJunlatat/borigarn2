import 'dart:io';

import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/datasource/booking_datasource.dart';
import 'package:borigarn/core/datasource/location_datasource.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/core/prefs/prefs.dart';
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
import 'package:image_picker/image_picker.dart';
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
    if (name.isEmpty) {
      //todo กรุณาระบุชื่อผู้ใช้งาน
      AppToast.failed(message: "Please enter your name.");
      return;
    }

    if (email.isEmpty) {
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
    } catch (e) {
      //todo อัพเดทโปรไฟล์ไม่สำเร็จ
      AppToast.failed(message: "Profile update unsuccessful.");
      EasyLoading.dismiss();
    }
  }

  Future<void> deleteAccount(int? userId) async {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.48),
      context: rootContext()!,
      builder: (context) {
        return AppConfirmDialog(
          title: context.tr(LocaleKeys.deleteAccountWording),
          message: '',
          buttons: const [AppButtonDialogType.cancel, AppButtonDialogType.ok],
          onPressed: (buttonType) async {
            if(buttonType == AppButtonDialogType.ok) {
              try {
                EasyLoading.show();
                final response = await ref.read(authenDatasourceProvider).deleteAccount(userId!);
                SharedPrefs().setToken = '';
                EasyLoading.dismiss();
                ref.read(goRouterProvider).pushNamed('login');
              } catch (e) {
                AppToast.failed(message: e.toError());
                EasyLoading.dismiss();
              }
            }
          },
        );
      },
    );
  }


  Future<void> uploadProfile(int? userId) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if(image != null) {
        EasyLoading.show();
        final uploadImage = await ref.read(bookingDatasourceProvider).uploadImage([File(image.path ?? '')], userId);
        final upload = await ref.read(authenDatasourceProvider).editProfile(uploadImage.first);
        ref.invalidate(getUserProvider);
        EasyLoading.dismiss();
      }
    }catch(e) {
      EasyLoading.dismiss();
      AppToast.failed(message: e.toError());
    }


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
            if (buttonType == AppButtonDialogType.ok) {
              SharedPrefs().setToken = '';
              ref.read(goRouterProvider).pushNamed('login');
            }
          },
        );
      },
    );
  }
}
