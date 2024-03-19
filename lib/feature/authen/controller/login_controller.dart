import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/utils/error.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/reset_password_payload.dart';
import 'package:borigarn/feature/authen/models/verify_otp_model.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      AppToast.success(message: 'Reset password is success');
      Future.delayed(2.seconds, () {
        ref.read(goRouterProvider).popUntilPath('/login');
      });
      EasyLoading.dismiss();
    }catch(error) {
      EasyLoading.dismiss();
      AppToast.failed(message: error.toString());
    }
  }

  Future<void> googleSignin(OAuthCredential credential) async {
    int x = 0;
    List<int> xxx = [1,2,4];
    EasyLoading.show();

    // try {
    //   final response = await ref.read(authenDatasourceProvider).resetPassword(payload);
    //   AppToast.success(message: 'Reset password is success');
    //   Future.delayed(2.seconds, () {
    //     ref.read(goRouterProvider).popUntilPath('/login');
    //   });
    //   EasyLoading.dismiss();
    // }catch(error) {
    //   EasyLoading.dismiss();
    //   AppToast.failed(message: error.toString());
    // }
  }



}
