import 'dart:io';

import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/manager/dio_manager.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/prefs/prefs.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/utils/error.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/reset_password_payload.dart';
import 'package:borigarn/feature/authen/models/payload/sso_credential.dart';
import 'package:borigarn/feature/authen/state/sso_payload.dart';
import 'package:borigarn/feature/authen/state/user_name_state.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/home/types/app_button_dialog_type.dart';
import 'package:borigarn/feature/home/widgets/confirm_dialog.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:device_info_plus/device_info_plus.dart';

part 'login_controller.g.dart';

@Riverpod(keepAlive: true)
LoginController loginController(LoginControllerRef ref) {
  return LoginController(ref);
}

class LoginController {
  final ProviderRef ref;

  LoginController(this.ref);

  Future<void> requestOTP(RequestOTPPayload payload) async {
    try {
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
      final response = await ref.read(authenDatasourceProvider).requestOTP(payload);
      response.phoneNumber = payload.phone;
      EasyLoading.dismiss();
      ref.read(goRouterProvider).pushNamed('verify_otp', extra: (response, payload.action));
    } catch (e) {
      AppToast.failed(message: e.toError());
      EasyLoading.dismiss();
    }
  }

  Future<void> resetPassword(ResetPasswordPayload payload) async {
    EasyLoading.show();
    try {
      final response = await ref.read(authenDatasourceProvider).resetPassword(payload);
      AppToast.success(message: rootContext()!.tr(LocaleKeys.resetPasswordSuccessMessage));
      Future.delayed(2.seconds, () {
        EasyLoading.dismiss();
        ref.read(goRouterProvider).popUntilPath('/login');
      });
    } catch (error) {
      EasyLoading.dismiss();
      AppToast.failed(message: error.toString());
    }
  }

  Future<void> login(String username, String password) async {
    EasyLoading.show();
    try {
      String deviceId;
      String uniqueId;
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        uniqueId = iosInfo.utsname.machine;
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.model;
        uniqueId = androidInfo.id;
      }
      final response = await ref.read(authenDatasourceProvider).login(username, password, uniqueId, deviceId);
      log.e(response.accessToken);
      SharedPrefs().setToken = response.accessToken ?? '';
      SharedPrefs().setUserId = response.userId;
      EasyLoading.dismiss();
      ref.invalidate(dioClientProvider);
      ref.read(goRouterProvider).pop();
    } catch (e) {
      EasyLoading.dismiss();
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.loginError));
    }
  }

  Future<void> loginSSO(String openId, String openToken, String openType, String email, String name) async {
    EasyLoading.show();
    try {
      final response = await ref.read(authenDatasourceProvider).loginSSO(openId, openToken, openType, email);
      if (response?.accessToken == null) {
        EasyLoading.dismiss();
        final sso = SSOCredential(name: name, email: email, openId: openId, openToken: openToken, openType: openType);
        ref.read(sSOPayloadProvider.notifier).setPayload(sso);
        ref.read(goRouterProvider).pushNamed('request_otp', extra: AuthenticationOTPType.registerSSO);
        return;
      }
      SharedPrefs().setToken = response?.accessToken ?? '';
      SharedPrefs().setUserId = response?.userId;
      EasyLoading.dismiss();
      ref.invalidate(dioClientProvider);
      ref.read(goRouterProvider).pop();
    } catch (e) {
      EasyLoading.dismiss();
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.loginError));
    }
  }

  Future<void> register(String name, String email, String password, String confirmPass, String phone) async {
    if (!password.contains(confirmPass)) {
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.passwordNotMatch));
      return;
    }
    EasyLoading.show();
    try {
      final response = await ref.read(authenDatasourceProvider).register(name, email, password, phone);
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.48),
        context: rootContext()!,
        builder: (context) {
          return AppConfirmDialog(
            title: '',
            message: rootContext()!.tr(LocaleKeys.registerSuccess),
            buttons: const [AppButtonDialogType.gotoLogin],
            onPressed: (type) {
              ref.read(usernameStateProvider.notifier).setUsername(email);
              ref.read(goRouterProvider).popUntilPath('/login');
            },
          );
        },
      );
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
      AppToast.failed(message: error.toString());
    }
  }




  Future<void> registerSSO(String password, String phone) async {
    final ssoPayload = ref.read(sSOPayloadProvider);
    EasyLoading.show();

    try {
      final register = await ref.read(authenDatasourceProvider).registerSSO(
          ssoPayload?.name ?? '',
          ssoPayload?.openId ?? '',
          ssoPayload?.openToken ?? '',
          ssoPayload?.openType ?? '',
          ssoPayload?.email ?? '',
          phone,
          password
      );
      if(register) {
        EasyLoading.dismiss();
        showDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.48),
          context: rootContext()!,
          builder: (context) {
            return AppConfirmDialog(
              title: '',
              message: rootContext()!.tr( LocaleKeys.registerSuccess),
              buttons: const [AppButtonDialogType.gotoLogin],
              onPressed: (type) {
                ref.read(usernameStateProvider.notifier).setUsername('');
                ref.read(goRouterProvider).popUntilPath('/login');
              },
            );
          },
        );
      }else {
        EasyLoading.dismiss();
        AppToast.failed(message: 'Register failed');
      }
    }catch(e) {
      EasyLoading.dismiss();
      AppToast.failed(message: 'Register failed');
    }

  }
}
