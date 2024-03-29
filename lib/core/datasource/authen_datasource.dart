import 'package:borigarn/core/constant/constants.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/manager/network2.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/core/prefs/prefs.dart';
import 'package:borigarn/feature/authen/models/payload/reset_password_payload.dart';
import 'package:borigarn/feature/authen/models/request_otp_model.dart';
import 'package:borigarn/feature/authen/models/token_model.dart';
import 'package:borigarn/feature/authen/models/user_info.dart';
import 'package:borigarn/feature/authen/models/user_model.dart';
import 'package:borigarn/feature/authen/models/verify_otp_model.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/verify_otp_payload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authen_datasource.g.dart';

@Riverpod(keepAlive: true)
AuthenDatasource authenDatasource(AuthenDatasourceRef ref) {
  return AuthenDatasourceImpl(ref.watch(networkManagerProvider), ref.watch(networkManager2Provider));
}


abstract class AuthenDatasource {
  Future<RequestOTPModel> requestOTP(RequestOTPPayload payload);
  Future<VerifyOTPModel> verifyOTP(VerifyOTPPayload payload);
  Future<bool> resetPassword(ResetPasswordPayload payload);
  Future<UserModel> getUser(int id);
  Future<TokenModel> login(String username, String password, String deviceId, String deviceName);
  Future<TokenModel?> loginSSO(String openId, String openToken, String openType, String email );

  Future<bool> register(String name, String email, String password, String phone);
  Future<bool> registerSSO(String name, String openId, String openToken, String openType, String email, String phone, String password);

  Future<bool> updateUser(String name, String email);
  Future<bool> deleteAccount(int userId);

  Future<bool> editProfile(String path);


  Future<List<AuthUserInfo>> checkUserExist(String phoneNumber);

// Future<bool> googleSignin(ResetPasswordPayload payload);
}

class AuthenDatasourceImpl implements AuthenDatasource {
  final NetworkManager networkManager;
  final NetworkManager2 networkManager2;

  AuthenDatasourceImpl(this.networkManager, this.networkManager2);

  final String appBaseUrl = SERVICE_MEMBER_URL;
  final String userService = SERVICE_USER_V2_URL;

  @override
  Future<RequestOTPModel> requestOTP(RequestOTPPayload payload) async {
    log.e(payload.action);
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
  Future<UserModel> getUser(int id) async {
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
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<AuthUserInfo>> checkUserExist(String phoneNumber) async{
    try {
      // log.e('check it' );
      final response = await networkManager2.get('/users/check', queryParameters: {'phone': phoneNumber}, appBaseUrl: userService, onlyData: true);
      final listData = response['items'] as List;
      final totalList = listData.map((e) => AuthUserInfo.fromJson(e)).toList();
      return totalList;
    }catch(e) {
      return [];
    }
  }

  @override
  Future<TokenModel> login(String username, String password, String deviceId, String deviceName) async {
    return networkManager.post('/customer/grant_token',
        fromJson: TokenModel.fromJson,
        data: {'grant_type': 'hash',
          'username': username,
          'password':password,
          'deviceId': deviceId,
          'device_name': deviceName,
          'domain': 'customer',
          'transaction_channel': 'mobile'
        },
        appBaseUrl: userService, onlyData: true);
  }




  @override
  Future<bool> deleteAccount(int userId) async {
    try {
      final response = await networkManager.delete('/customer/$userId',
          fromJson: TokenModel.fromJson,
          queryParameters: {'id': userId,
          },
          appBaseUrl: userService, onlyData: true);
      return true;
    }catch(e) {
      rethrow;
    }

  }

  @override
  Future<bool> register(String name, String email, String password, String phone) async {
    try {
      final response = await networkManager.post('/customer/create',
          data: {
            "password": password,
            "group_id": 1,
            "name": name,
            "phone": phone,
            "email": email,
            "referral_code": ""
          },
          appBaseUrl: userService, onlyData: true);
      log.e('ON register ${response}');
      // printWrapped(response);
      return true;
    }catch(e) {
      rethrow;
    }
  }

  @override
  Future<TokenModel?> loginSSO(String openId, String openToken, String openType, String email) async {
    try {
      final response = await networkManager.post('/customer/grant_token',
          data: {
            "group_id": 1,
            "phone": "",
            "email": email,
            "referral_code": "",
            "grant_type" : "open_id",
            "openType" : openType,
            "openToken" : openToken,
            "openId" : openId,
            "domain": "customer",
            "transaction_channel": "Mobile App"
          },
          appBaseUrl: userService, onlyData: true, rawResponse: true);
      log.e("YORES ${response}");
      if(response.data['data'] != null) {
        return TokenModel.fromJson(response.data['data']);
      }else {
        return null;
      }
    }catch(e) {
      rethrow;
    }
  }

  @override
  Future<bool> registerSSO(String name, String openId, String openToken, String openType, String email, String phone, String password) async {
    log.e(name);
    log.e(email);
    log.e(openToken);

    try {
      final response = await networkManager.post('/customer/create',
          data: {
            "password": password,
            "group_id": 1,
            "name": name,
            "phone": phone,
            "email": email,
            "openType" : openType,
            "openToken" : openToken,
            "openId" : openId,
            "referral_code": ""
          },
          appBaseUrl: userService, onlyData: true);
      return true;
    }catch(e) {
      rethrow;
    }
  }

  @override
  Future<bool> editProfile(String path) async {
    try {
      final response = await networkManager.patch('/customer/update', data: {'picture_url': path}, appBaseUrl: userService, fromJson: null);
      log.e(response);
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
