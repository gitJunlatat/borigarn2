import 'package:borigarn/core/constant/constants.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/feature/authen/models/payload/reset_password_payload.dart';
import 'package:borigarn/feature/authen/models/request_otp_model.dart';
import 'package:borigarn/feature/authen/models/user_model.dart';
import 'package:borigarn/feature/authen/models/verify_otp_model.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/verify_otp_payload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authen_datasource.g.dart';

@Riverpod(keepAlive: true)
AuthenDatasource authenDatasource(AuthenDatasourceRef ref) {
  return AuthenDatasourceImpl(ref.watch(networkManagerProvider));
}

// API_CREATE_CUSTOMER_ENDPOINT ='https://borigarn-users-sit.bluekingkong.com/v2/customer/create'
// API_REGISTER_REQUEST_OTP='https://borigarn-member-sit.bluekingkong.com/auth/otp/request'
// API_REGISTER_VERIFY_OTP='https://borigarn-member-sit.bluekingkong.com/auth/otp/verify'
// API_CHECK_USER='https://borigarn-users-sit.bluekingkong.com/v2/users/check'

abstract class AuthenDatasource {
  Future<RequestOTPModel> requestOTP(RequestOTPPayload payload);

  Future<VerifyOTPModel> verifyOTP(VerifyOTPPayload payload);

  Future<bool> resetPassword(ResetPasswordPayload payload);

  Future<UserModel> getUser(String id);

  Future<bool> updateUser(String name, String email);

// Future<bool> googleSignin(ResetPasswordPayload payload);
}

class AuthenDatasourceImpl implements AuthenDatasource {
  final NetworkManager networkManager;

  AuthenDatasourceImpl(this.networkManager);

  final String appBaseUrl = SERVICE_MEMBER_URL;
  final String userService = SERVICE_USER_V2_URL;

  @override
  Future<RequestOTPModel> requestOTP(RequestOTPPayload payload) async {
    final response = await networkManager.post('/auth/otp/request',
        data: {
          'mobile_no': payload.phone,
          'action': payload.action.action,
          'transaction_channel': 'mobile',
          'device_info': payload.deviceId,
          'device_id': payload.uniqueId,
          'channel': 'Application',
        },
        appBaseUrl: appBaseUrl,
        onlyData: true);

    return RequestOTPModel.fromJson(response);
  }

  // API_RESET_PASSWORD = 'https://borigarn-users-sit.bluekingkong.com/v2/customer/reset_credential'

  @override
  Future<bool> resetPassword(ResetPasswordPayload payload) async {
    try {
      final response = await networkManager.post('/customer/reset_credential',
          data: {
            'new_password': payload.pass,
            'phone': payload.phoneNumber,
            'requestId': payload.requestId,
          },
          appBaseUrl: userService,
          onlyData: true);
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<VerifyOTPModel> verifyOTP(VerifyOTPPayload payload) async {
    final response = await networkManager.post('/auth/otp/verify',
        data: {
          'request_id': payload.requestModel.requestId,
          'ref_code': payload.requestModel.refCode,
          'otp_code': payload.otpCode,
          'action': payload.action.action,
        },
        appBaseUrl: appBaseUrl,
        onlyData: true);
    return VerifyOTPModel.fromJson(response);
  }

  @override
  Future<UserModel> getUser(String id) async {
    return networkManager.get('/users/$id', appBaseUrl: userService, fromJson: UserModel.fromJson, onlyData: true);
  }

  @override
  Future<List<LocationModel>> getLocation() async {
    final response = await networkManager.get('/user-location', appBaseUrl: userService, onlyData: true);
    final listData = response['items'] as List;
    final totalList = listData.map((e) => LocationModel.fromJson(e)).toList().toList();
    return totalList;
  }

  @override
  Future<bool> updateUser(String name, String email) async {
    try {
      final response = await networkManager.patch('/customer/update', data: {'name': name, 'email': email}, appBaseUrl: userService, fromJson: null);
      log.d(response);
      return true;
    } catch (e) {
      return false;
    }
  }

//   @override
//   Future<bool> googleSignin(OAuthCredential cred) async {
//     final response = await networkManager.post('/auth/otp/verify',
//         data: {
//           'openToken': cred.accessToken,
//           'openId': cred.idToken,
//           'ref_code': payload.requestModel.refCode,
//           'otp_code': payload.otpCode,
//           'action': payload.action.action,
//         },
//         appBaseUrl: appBaseUrl,
//         onlyData: true);
//
//     return VerifyOTPModel.fromJson(response);
//   }
}
