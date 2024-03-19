import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/authen/type/login_form_type.dart';
import 'package:borigarn/feature/authen/type/sso_type.dart';
import 'package:borigarn/feature/authen/widgets/login_text_field.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/login_controller.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<LoginFormType> sectionType = LoginFormType.values;
    // final controller = ref.watch(loginControllerProvider);

    final TextEditingController usernameTextController = useTextEditingController();
    final TextEditingController passwordTextController = useTextEditingController();
    final FocusNode usernameFocusNode = useFocusNode();
    final FocusNode passwordFocusNode = useFocusNode();

    return Scaffold(
      backgroundColor: context.appColors.light,
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dont have an account ?', style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),),
            const Gap(4),
            Text('Sign Up', style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),)
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Column(
              children: [
                MyAssets.logoSecond.image(width: 250.w, height: 150.h),
                const Gap(40),
                ...sectionType.map((element) {
                  final TextEditingController controller;
                  final FocusNode focusNode;
                  switch (element) {
                    case LoginFormType.username:
                      controller = usernameTextController;
                      focusNode = usernameFocusNode;
                    case LoginFormType.password:
                      controller = passwordTextController;
                      focusNode = passwordFocusNode;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.getTextFieldName(),
                        style: context.textTheme.bodyMedium,
                      ),
                      const Gap(8),
                      LoginTextField(
                        sectionType: element,
                        controller: controller,
                        focusNode: focusNode,
                      ),
                      const Gap(16),
                    ],
                  );
                }),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // context.pushNamed(
                        //   'auth-phone-number',
                        //   queryParameters: {
                        //     'type': AuthenticationOTPType.loginBySms.getStringPathParams(),
                        //   },
                        // );
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        child: Text(
                          "Remember Me",
                          style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // context.pushNamed(
                        //   'auth-phone-number',
                        //   queryParameters: {
                        //     'type': AuthenticationOTPType.forgotPassword.getStringPathParams(),
                        //   },
                        // );
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        child: InkWell(
                          onTap: () {
                            context.pushNamed('request_otp', extra: AuthenticationOTPType.forgotPassword);
                          },
                          child: Row(
                            children: [
                              Text(
                                "ลืมรหัสผ่าน",
                                style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),
                              ),
                              const Gap(4),
                              Icon(
                                Icons.question_mark_sharp,
                                size: 14,
                                color: context.appColors.subPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                HookBuilder(
                  builder: (context) {
                    final userIdNotEmpty = useListenableSelector(usernameTextController, () => usernameTextController.text.isNotEmpty);
                    final passwordNotEmpty = useListenableSelector(passwordTextController, () => passwordTextController.text.isNotEmpty);
                    final enable = userIdNotEmpty && passwordNotEmpty;
                    return ButtonWidget(
                      onPressed: () => {()},
                      //     controller.loginByMyPinMall(
                      //   user: usernameTextController.text,
                      //   password: passwordTextController.text,
                      // ),
                      height: 50,
                      enable: enable,
                      borderColor: context.appColors.primary,
                      borderWidth: 1,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      backgroundColor: context.appColors.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "เข้าสู่ระบบ",
                            style: context.textTheme.bodyMedium?.apply(color: enable ? context.appColors.light : context.appColors.black.withOpacity(0.25)),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const Gap(16),
                Text(
                  'OR CONNECT WITH',
                  style: context.textTheme.labelSmall?.apply(color: context.appColors.secondaryText),
                ),
                const Gap(36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //For default Button
        
                    Expanded(
                        child: ButtonWidget(
                          height: 50,
                          radius: 12,
                          onPressed: () {
                            signInWithGoogle();
                          },
                          borderColor: context.appColors.border,
                          borderWidth: 1,
                          backgroundColor: SSOType.google.background,
                          child: SSOType.google.icon.svg(width: 20, height: 20),
                        )),
        
                    const Gap(20),
                    Expanded(
                        child: ButtonWidget(
                          height: 50,
                          radius: 12,
                          onPressed: () {},
                      backgroundColor: SSOType.facebook.background,
                      child: SSOType.facebook.icon.svg(width: 20, height: 20),
                    )),
        
                    const Gap(22),
                    Expanded(
                        child: ButtonWidget(
                          radius: 12,
                          height: 50,
                          onPressed: () {},
                          borderWidth: 0,
                          backgroundColor: SSOType.apple.background,
                          child: SSOType.apple.icon.svg(width: 20, height: 20),
                        )),
        
        
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );


      final xxx =  await FirebaseAuth.instance.signInWithCredential(credential);


      return xxx;

    } on Exception catch (e) {
      print('exception->$e');
    }
  }
}
