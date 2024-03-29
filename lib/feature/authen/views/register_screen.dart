import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/date.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/app_check_box_view.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/authen/controller/login_controller.dart';
import 'package:borigarn/feature/profile/types/edit_form_type.dart';
import 'package:borigarn/feature/profile/types/settings_menu_type.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/verify_otp_model.dart';
import '../type/authen_flow_type.dart';

class RegisterScreen extends HookConsumerWidget {
  final VerifyOTPModel model;
  final AuthenticationOTPType otpType;

  const RegisterScreen({super.key, required this.model, required this.otpType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final check1 = useState<bool>(false);
    final check2 = useState<bool>(false);

    return Scaffold(
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(
        title: context.tr(LocaleKeys.signup),
        isCenterTitle: true,
        isShowBorder: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyAssets.logoSecond.image(width: 150.w, height: 75.h),
              Gap(40),
              MainCard(
                radius: 20,
                borderColor: context.appColors.border,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (otpType != AuthenticationOTPType.registerSSO)
                      Text(
                        EditFormType.name.title,
                        style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                      ),
                    if (otpType != AuthenticationOTPType.registerSSO)
                      const Gap(8),
                    if (otpType != AuthenticationOTPType.registerSSO)
                      AppTextField(
                        hintText: EditFormType.name.title,
                        controller: usernameController,
                        prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.name.icon.svg(width: 16, height: 16)),
                      ),
                    if (otpType != AuthenticationOTPType.registerSSO)
                      const Gap(20),
                    if (otpType != AuthenticationOTPType.registerSSO)
                      Text(
                        EditFormType.email.title,
                        style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                      ),
                    if(otpType != AuthenticationOTPType.registerSSO)
                      const Gap(8),
                    if(otpType != AuthenticationOTPType.registerSSO)
                      AppTextField(
                        hintText: EditFormType.email.title,
                        controller: emailController,
                        prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.email.icon.svg(width: 16, height: 16))),
                    if(otpType != AuthenticationOTPType.registerSSO)
                     const Gap(20),
                    Text(
                      EditFormType.password.title,
                      style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                    ),
                    const Gap(8),
                    HookBuilder(builder: (context) {
                      final hidePassword = useState<bool>(true);
                      return AppTextField(
                        controller: passwordController,
                        // focusNode: focusNode,
                        prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.password.icon.svg(width: 16, height: 16)),
                        obscureText: hidePassword.value,
                        hintText: EditFormType.password.title,
                        suffixIcon: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => hidePassword.value = !hidePassword.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            child: Icon(
                              hidePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 14,
                              color: context.appColors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                    const Gap(20),
                    Text(
                      EditFormType.confirmPassword.title,
                      style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                    ),
                    const Gap(8),
                    HookBuilder(builder: (context) {
                      final hidePassword = useState<bool>(true);
                      return AppTextField(
                        controller: confirmPasswordController,
                        prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.confirmPassword.icon.svg(width: 16, height: 16)),
                        // focusNode: focusNode,
                        obscureText: hidePassword.value,
                        hintText: EditFormType.confirmPassword.title,
                        suffixIcon: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => hidePassword.value = !hidePassword.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            child: Icon(
                              hidePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 14,
                              color: context.appColors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Gap(20),
              HookConsumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Row(
                    children: [
                      AppCheckBoxView(
                          isCheck: check1.value,
                          isDisable: false,
                          onChange: (current) {
                            check1.value = current;
                          },
                          tapPadding: const EdgeInsets.all(10)),
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          check1.value = !check1.value;
                        },
                        child: Text(
                          context.tr(LocaleKeys.agreeTo),
                          style: context.textTheme.labelMedium?.apply(color: context.appColors.title),
                        ),
                      ),
                      const Gap(4),
                      InkWell(
                        onTap: () {
                          context.pushNamed("privacy", extra: SettingMenuType.termAndCondition);
                        },
                        child: Text(
                          context.tr(LocaleKeys.tacMessage),
                          style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),
                        ),
                      )
                    ],
                  );
                },
              ),
              Gap(12),
              HookConsumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Row(
                    children: [
                      AppCheckBoxView(
                          isCheck: check2.value,
                          isDisable: false,
                          onChange: (current) {
                            check2.value = current;
                          },
                          tapPadding: const EdgeInsets.all(10)),
                      const Gap(8),
                      InkWell(
                        onTap: () {
                          check2.value = !check2.value;
                        },
                        child: Text(
                          context.tr(LocaleKeys.agreeTo),
                          style: context.textTheme.labelMedium?.apply(color: context.appColors.title),
                        ),
                      ),
                      const Gap(4),
                      InkWell(
                        onTap: () {
                          context.pushNamed("privacy", extra: SettingMenuType.privacy);
                        },
                        child: Text(
                          context.tr(LocaleKeys.privacyMessage),
                          style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),
                        ),
                      )
                    ],
                  );
                },
              ),
              HookBuilder(
                builder: (context) {
                  final usernameIsNotEmpty = useListenableSelector(usernameController, () => usernameController.text.isNotEmpty);
                  final emailIsNotEmpty = useListenableSelector(emailController, () => emailController.text.isNotEmpty);
                  final passwordIsNotEmpty = useListenableSelector(passwordController, () => passwordController.text.isNotEmpty);
                  final confirmPassword = useListenableSelector(confirmPasswordController, () => confirmPasswordController.text.isNotEmpty);

                  final enable = (otpType != AuthenticationOTPType.registerSSO) ? (usernameIsNotEmpty && emailIsNotEmpty && passwordIsNotEmpty && confirmPassword && check1.value && check2.value) : (passwordIsNotEmpty && confirmPassword && check1.value && check2.value);

                  return ButtonWidget(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if(otpType != AuthenticationOTPType.registerSSO) {
                        ref
                            .read(loginControllerProvider)
                            .register(usernameController.text, emailController.text, passwordController.text, confirmPasswordController.text, model.phonNumber ?? '');
                      }else {
                        ref
                            .read(loginControllerProvider)
                            .registerSSO(passwordController.text, model.phonNumber ?? '');
                      }

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
                          context.tr(LocaleKeys.confirmButton),
                          style: context.textTheme.bodyMedium?.apply(color: enable ? context.appColors.light : context.appColors.black.withOpacity(0.25)),
                        )
                      ],
                    ),
                  );
                },
              ),
              const Gap(16),
              Container(
                height: 70,
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr(LocaleKeys.haveAnAccount),
                      style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
                    ),
                    const Gap(4),
                    InkWell(
                        onTap: () {
                          ref.read(goRouterProvider).popUntilPath('/login');
                        },
                        child: Text(
                          context.tr(LocaleKeys.login),
                          style: context.textTheme.labelMedium?.apply(color: context.appColors.subPrimary),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
