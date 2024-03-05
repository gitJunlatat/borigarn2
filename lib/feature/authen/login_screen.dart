import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/authen/type/LoginFormType.dart';
import 'package:borigarn/feature/authen/widgets/login_text_field.dart';
import 'package:borigarn/feature/authen/widgets/main_appbar.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'controller/login_controller.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<LoginFormType> sectionType = LoginFormType.values;
    final controller = ref.watch(loginControllerProvider);

    final TextEditingController usernameTextController = useTextEditingController();
    final TextEditingController passwordTextController = useTextEditingController();
    final FocusNode usernameFocusNode = useFocusNode();
    final FocusNode passwordFocusNode = useFocusNode();



    // controller.addTelFormatListener(
    //   usernameTextController: usernameTextController,
    //   usernameFocusNode: usernameFocusNode,
    //   ref: ref,
    // );

    return Scaffold(
      appBar: const MainAppbar(),
      backgroundColor: context.appColors.light,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            children: [
              Image.asset(MyAssets.splashLogo.path, width: 192.w,),
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
                        "เข้าสู่ระบบด้วย SMS",
                        style: context.textTheme.bodySmall?.apply(color: context.appColors.primary),
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.question_mark_sharp,
                            size: 14,
                            color: context.appColors.primary,
                          ),
                          const Gap(4),
                          Text(
                            "ลืมรหัสผ่าน",
                            style: context.textTheme.bodySmall?.apply(color: context.appColors.primary),
                          ),
                        ],
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
                    height: 38,
                    enable: enable,
                    borderColor: context.appColors.primary,
                    borderWidth: 1,
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    backgroundColor: context.appColors.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          size: 14,
                          color: enable ? context.appColors.light : context.appColors.black.withOpacity(0.25),
                        ),
                        Gap(8),
                        Text(
                          "เข้าสู่ระบบ",
                          style: context.textTheme.bodyMedium?.apply(color: enable ? context.appColors.light : context.appColors.black.withOpacity(0.25)),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
