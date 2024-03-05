
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@Riverpod(keepAlive: true)
LoginController loginController(LoginControllerRef ref) {
  return LoginController(ref);
}

class LoginController {
  final ProviderRef ref;
  LoginController(this.ref);


  // void addTelFormatListener({
  //   required TextEditingController usernameTextController,
  //   required FocusNode usernameFocusNode,
  //   required WidgetRef ref,
  // }) {
  //   usernameFocusNode.addListener(() {
  //     String userText = usernameTextController.text.split("-").join();
  //     bool userCheck = RegExpList.regexMbNumber.hasMatch(userText);
  //     if (userCheck) {
  //       final formatTel = "${userText.substring(0, 3)}-${userText.substring(3, 6)}-${userText.substring(6)}";
  //       if (!usernameFocusNode.hasFocus) {
  //         usernameTextController.text = formatTel;
  //       } else {
  //         usernameTextController.text = userText.split("-").join();
  //       }
  //       ref.watch(telUserNameProvider.notifier).setCurrentUserName(formatTel);
  //     } else {
  //       ref.invalidate(telUserNameProvider);
  //     }
  //   });
  // }

  // Future<void> showLoginErrorDialog(NetworkException e) {
  //   if (e.statusCode == 404) {
  //     return showDialog<void>(
  //       context: rootContext()!,
  //       barrierColor: rootContext()!.appColors.black.withOpacity(0.48),
  //       barrierDismissible: true,
  //       builder: (BuildContext dialogContext) {
  //         return const WarningDialog(
  //           title: 'อีเมลหรือเบอร์โทรศัพท์ไม่ถูกต้อง',
  //           subTitle: 'กรุณาตรวจสอบอีเมลหรือเบอร์โทรศัพท์',
  //           buttonText: 'กรอกข้อมูลใหม่อีกครั้ง',
  //         );
  //       },
  //     );
  //   }
  //   if (e.statusCode == 401) {
  //     return showDialog<void>(
  //       context: rootContext()!,
  //       barrierColor: rootContext()!.appColors.black.withOpacity(0.48),
  //       barrierDismissible: true,
  //       builder: (BuildContext dialogContext) {
  //         return const WarningDialog(
  //           title: 'รหัสผ่านไม่ถูกต้อง',
  //           subTitle: 'กรุณาตรวจสอบรหัสผ่านของคุณให้ถูกต้อง\nและลองใหม่อีกครั้ง',
  //           buttonText: 'กรอกข้อมูลใหม่อีกครั้ง',
  //         );
  //       },
  //     );
  //   }
  //   return showDialog<void>(
  //     context: rootContext()!,
  //     barrierDismissible: true,
  //     barrierColor: Colors.transparent,
  //     builder: (BuildContext dialogContext) {
  //       return const ErrorDialog();
  //     },
  //   );
  // }
  //
  // void setLoginToken({
  //   required String accessToken,
  //   loginType = "MyPinmall",
  // }) {
  //   SharedPrefs().setToken = accessToken;
  //   SharedPrefs().loginType = loginType;
  //   ref.invalidate(dioClientProvider);
  //
  //   //Todo use network cilents
  //   ref.invalidate(getPinProductIdsProvider);
  //   ref.invalidate(basketCountProvider);
  // }
  //
  // Future<void> loginWithMyOrder({
  //   required String email,
  //   required String password,
  //   required String secretKey,
  // }) async {
  //   try {
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     EasyLoading.show();
  //     final String passwordHashed = sha256.convert(utf8.encode(password)).toString();
  //     final loginWithSecretKey = await ref.read(authenticationMyOrderRepositoryProvider).loginWithSecretKey(
  //       email: email,
  //       password: passwordHashed,
  //       secretKey: secretKey,
  //     );
  //     SharedPrefs().setToken = loginWithSecretKey.accessToken ?? "";
  //     ref.invalidate(dioClientProvider);
  //
  //     final tokenResponse = await ref.read(authenticationRepositoryProvider).loginWithMyOrder(
  //       profile: loginWithSecretKey.profile ?? "",
  //       profileImg: loginWithSecretKey.profileImg ?? "",
  //     );
  //     print(tokenResponse.accessToken);
  //     setLoginToken(
  //       accessToken: tokenResponse.accessToken,
  //       loginType: "MyOrder",
  //     );
  //     EasyLoading.dismiss();
  //     ref.read(goRouterProvider).popUntilPath('/login');
  //     ref.read(goRouterProvider).pop();
  //   } on NetworkException catch (e) {
  //     EasyLoading.dismiss();
  //     _handleLoginByMyOrderError(e);
  //   }
  // }
  //
  // Future<void> _handleLoginByMyOrderError(NetworkException e) {
  //   if (e.statusCode == 401) {
  //     if (e.data["name"] == "UnAuthorizedException") {
  //       return showDialog(
  //         context: rootContext()!,
  //         barrierColor: rootContext()!.appColors.black.withOpacity(0.48),
  //         barrierDismissible: true,
  //         builder: (BuildContext dialogContext) {
  //           return const WarningDialog(
  //             title: 'รหัสผ่านไม่ถูกต้อง',
  //             subTitle: 'กรุณาตรวจสอบรหัสผ่านของคุณให้ถูกต้อง\nและลองใหม่อีกครั้ง',
  //             buttonText: 'กรอกข้อมูลใหม่อีกครั้ง',
  //           );
  //         },
  //       );
  //     }
  //     if (e.data['name'] == "EmailNotFoundException") {
  //       return showDialog(
  //         context: rootContext()!,
  //         barrierColor: rootContext()!.appColors.black.withOpacity(0.48),
  //         barrierDismissible: true,
  //         builder: (BuildContext dialogContext) {
  //           return const WarningDialog(
  //             title: 'ไม่พบบัญชีนี้',
  //             subTitle: 'โปรดใช้บัญชีอื่นหรือลงทะเบียนสำหรับบัญชีใหม่',
  //             buttonText: 'กรอกข้อมูลใหม่อีกครั้ง',
  //           );
  //         },
  //       );
  //     }
  //   }
  //   if (e.statusCode == 400) {
  //     return showDialog(
  //       context: rootContext()!,
  //       barrierColor: rootContext()!.appColors.black.withOpacity(0.48),
  //       barrierDismissible: true,
  //       builder: (BuildContext dialogContext) {
  //         return const WarningDialog(
  //           title: 'อีเมลหรือเบอร์โทรศัพท์ไม่ถูกต้อง',
  //           subTitle: 'กรุณาตรวจสอบอีเมลหรือเบอร์โทรศัพท์',
  //           buttonText: 'กรอกข้อมูลใหม่อีกครั้ง',
  //         );
  //       },
  //     );
  //   }
  //   if (e.statusCode == 403) {
  //     return showDialog(
  //       context: rootContext()!,
  //       barrierColor: rootContext()!.appColors.black.withOpacity(0.48),
  //       barrierDismissible: true,
  //       builder: (BuildContext dialogContext) {
  //         return WarningDialog(
  //           title: 'กรุณาทำการเข้าสู่ระบบใหม่อีกครั้ง',
  //           subTitle: 'เนื่องจากแอปพลิเคชันไม่ตอบสนองนานเกินไป',
  //           buttonText: 'เข้าสู่ระบบ',
  //           design2: true,
  //           onPressed: resetSecretKey,
  //         );
  //       },
  //     );
  //   }
  //   return showDialog<void>(
  //     context: rootContext()!,
  //     barrierDismissible: true,
  //     barrierColor: Colors.transparent,
  //     builder: (BuildContext dialogContext) {
  //       return const ErrorDialog();
  //     },
  //   );
  // }
  //
  // void resetSecretKey() {
  //   ref.invalidate(getMyOrderSecretKeyProvider);
  //   ref.read(goRouterProvider).pop();
  // }
}
