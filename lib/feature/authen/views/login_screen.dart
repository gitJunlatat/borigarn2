import 'dart:convert';
import 'dart:math';

import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/app_check_box_view.dart';
import 'package:borigarn/feature/authen/controller/login_controller.dart';
import 'package:borigarn/feature/authen/state/user_name_state.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/authen/type/login_form_type.dart';
import 'package:borigarn/feature/authen/type/sso_type.dart';
import 'package:borigarn/feature/authen/widgets/login_text_field.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<LoginFormType> sectionType = LoginFormType.values;
    final TextEditingController usernameTextController = useTextEditingController();
    final TextEditingController passwordTextController = useTextEditingController();
    final FocusNode usernameFocusNode = useFocusNode();
    final FocusNode passwordFocusNode = useFocusNode();
    final isRemember = useState<bool>(false);

    Future<dynamic> signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        final response =  await FirebaseAuth.instance.signInWithCredential(credential);
        final openId = response.user?.uid ?? '';
        final openToken = response.credential?.accessToken ?? '';
        final email = response.user?.email ?? '';
        final name = response.user?.displayName ?? '';
        ref.read(loginControllerProvider).loginSSO(openId , openToken, 'gmail', email, name);
      } on Exception catch (e) {
        AppToast.failed(message: e.toString());
      }
    }
    String generateNonce([int length = 32]) {
      final charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(length, (_) => charset[random.nextInt(charset.length)])
          .join();
    }
    /// Returns the sha256 hash of [input] in hex notation.
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    Future<void> signInWithApple() async {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      final credential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final openId = credential.user?.uid ?? '';
      final openToken = credential.credential?.accessToken ?? '';
      final email = credential.user?.email ?? '';
      final name = credential.user?.displayName ?? 'apple account';

      ref.read(loginControllerProvider).loginSSO(openId, openToken, 'gmail', email, name);
      log.d(credential);
    }


    Future<void> signInWithFacebook() async {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');
      final userInfo = FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      log.e(userInfo);
    }

    return WillPopScope(
      onWillPop: () async {
        log.e('onnpop');
        return false;
      },
      child: Scaffold(
        backgroundColor: context.appColors.light,
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
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final username = ref.watch(usernameStateProvider);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if(username != null && element == LoginFormType.username) {
                                controller.text = username ?? '';
                              }
                            });
                            return LoginTextField(
                              sectionType: element,
                              controller: controller,
                              focusNode: focusNode,
                            );
                          },
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
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          child: Row(
                            children: [
                              HookConsumer(
                                builder: (BuildContext context, WidgetRef ref, Widget? child) {

                                  return AppCheckBoxView(isCheck: isRemember.value, isDisable: false, onChange: (current ) {
                                    isRemember.value = current;
                                  }, tapPadding: const EdgeInsets.all(4));
                                },
                              ),
                              const Gap(8),
                              Text(
                                context.tr(LocaleKeys.rememberMe),
                                style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),
                              )
                            ], 
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
                                  context.tr(LocaleKeys.forgotPassword),
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
                        onPressed: ()  {
                          ref.read(loginControllerProvider).login(usernameTextController.text, passwordTextController.text);
                        },

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
                              context.tr(LocaleKeys.login),
                              style: context.textTheme.bodyMedium?.apply(color: enable ? context.appColors.light : context.appColors.black.withOpacity(0.25)),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const Gap(16),
                  Text(
                    context.tr(LocaleKeys.orConnectWith),
                    style: context.textTheme.labelMedium?.apply(color: context.appColors.secondaryText),
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
                            onPressed: () {
                              signInWithFacebook();
                            },
                        backgroundColor: SSOType.facebook.background,
                        child: SSOType.facebook.icon.svg(width: 20, height: 20),
                      )),

                      const Gap(22),
                      Expanded(
                          child: ButtonWidget(
                            radius: 12,
                            height: 50,
                            onPressed: () {
                              signInWithApple();
                            },
                            borderWidth: 0,
                            backgroundColor: SSOType.apple.background,
                            child: SSOType.apple.icon.svg(width: 20, height: 20),
                          )),


                    ],
                  ),
                  const Gap(36),

                  Container(
                    height: 70,
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.tr(LocaleKeys.doNotHaveAccount), style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),),
                        const Gap(4),
                        InkWell(onTap: () {
                          context.pushNamed('request_otp', extra: AuthenticationOTPType.register);
                        },child: Text(context.tr(LocaleKeys.signup), style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}


