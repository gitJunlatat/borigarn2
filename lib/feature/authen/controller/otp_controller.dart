import 'dart:io';

import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/manager/dio_manager.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/prefs/prefs.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/utils/error.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/feature/authen/models/otp_model.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/verify_otp_payload.dart';
import 'package:borigarn/feature/authen/state/otp_error_count.dart';
import 'package:borigarn/feature/authen/state/otp_ref_id.dart';
import 'package:borigarn/feature/authen/state/otp_timer.dart';
import 'package:borigarn/feature/authen/state/otp_verify_failed.dart';
import 'package:borigarn/feature/authen/state/sso_payload.dart';
import 'package:borigarn/feature/authen/state/user_name_state.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/home/types/app_button_dialog_type.dart';
import 'package:borigarn/feature/home/widgets/confirm_dialog.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'otp_controller.g.dart';

@riverpod
OtpController otpController(OtpControllerRef ref) {
  return OtpController(ref);
}

class OtpController {
  ProviderRef ref;

  OtpController(this.ref);

  String displayOtpNumber(
    String otpText,
    FocusNode otpFocusNode,
    int index,
  ) {
    if (index == otpText.length) {
      return otpFocusNode.hasFocus ? "|" : "";
    }
    if (index <= otpText.length - 1) {
      return otpText[index];
    }
    return "";
  }

  Future<void> renewOtp({
    required RequestOTPPayload payload,
    required TextEditingController otpTextController,
  }) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      payload.uniqueId = iosInfo.identifierForVendor ?? '';
      payload.deviceId = iosInfo.utsname.machine;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      payload.deviceId = androidInfo.model;
      payload.uniqueId = androidInfo.id;
    }
    EasyLoading.show();
    try {
      final otpResponse = await ref.read(authenDatasourceProvider).requestOTP(payload);
      otpTextController.clear();
      ref.read(otpRefIdProvider.notifier).setRefId(OTPModel(otpResponse.requestId ?? '', otpResponse.refCode ?? ''));
      ref.invalidate(otpErrorCountProvider);
      ref.invalidate(isOtpVerifyFailedProvider);
      ref.invalidate(otpTimerProvider);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      AppToast.failed(message: e.toError());
    }
  }

  Future<void> verifyOtp({
    required VerifyOTPPayload payload,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    EasyLoading.show();
    try {
      final verifyOtpResponse = await ref.read(authenDatasourceProvider).verifyOTP(payload);
      verifyOtpResponse.phonNumber = payload.requestModel.phoneNumber;
      switch (payload.action) {
        case AuthenticationOTPType.forgotPassword:
          ref.read(goRouterProvider).pushNamed('reset_password', extra: (verifyOtpResponse, payload.action));
        case AuthenticationOTPType.register:
          final users = await ref.read(authenDatasourceProvider).checkUserExist((payload.requestModel.phoneNumber ?? ''));
          if (users.firstOrNull != null) {
            showMessage('', "${rootContext()!.tr(LocaleKeys.userExist)}\n ${users.firstOrNull?.username ?? ''}", (type) {
              ref.read(usernameStateProvider.notifier).setUsername(users.firstOrNull?.username ?? '');
              ref.read(goRouterProvider).popUntilPath('/login');
            });
          } else {
            ref.read(goRouterProvider).pushNamed('register_screen', extra: (verifyOtpResponse, payload.action));
          }
        case AuthenticationOTPType.registerSSO:
          final users = await ref.read(authenDatasourceProvider).checkUserExist((payload.requestModel.phoneNumber ?? ''));
          if (users.firstOrNull != null) {
            showMessage('', "${rootContext()!.tr(LocaleKeys.userExist)}\n ${users.firstOrNull?.username ?? ''}", (type) {
              ref.read(usernameStateProvider.notifier).setUsername(users.firstOrNull?.username ?? '');
              ref.read(goRouterProvider).popUntilPath('/login');
            });
          } else {
            ref.read(goRouterProvider).pushNamed('register_screen', extra: (verifyOtpResponse, payload.action));
          }
      }
      EasyLoading.dismiss();
    } catch (e) {
      SharedPrefs().setToken = '';
      ref.invalidate(dioClientProvider);
      AppToast.failed(message: e.toError());
      EasyLoading.dismiss();
    }
  }

  Future<void> showMessage(String title, String message, Function(AppButtonDialogType)? onPressed) async {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.48),
      context: rootContext()!,
      builder: (context) {
        return AppConfirmDialog(
          title: title,
          message: message,
          buttons: const [AppButtonDialogType.gotoLogin],
          onPressed: onPressed,
        );
      },
    );
  }
}
