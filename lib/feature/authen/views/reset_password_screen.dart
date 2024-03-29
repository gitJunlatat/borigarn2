import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/authen/controller/login_controller.dart';
import 'package:borigarn/feature/authen/controller/otp_controller.dart';
import 'package:borigarn/feature/authen/models/payload/reset_password_payload.dart';
import 'package:borigarn/feature/authen/models/verify_otp_model.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/profile/types/edit_form_type.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  final VerifyOTPModel model;
  final AuthenticationOTPType otpType;

  const ResetPasswordScreen({super.key, required this.model, required this.otpType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController password = useTextEditingController();
    final TextEditingController confirmPassword = useTextEditingController();

    return Scaffold(
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(
        title: context.tr(LocaleKeys.createNewPassword),
        isShowBorder: false,
        isCenterTitle: true,
        leftNavigation: const [],
        rightNavigation: const [ActionNavigationType.close],
        callback: (type) {
          context.goNamed('login');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          child: Column(
            children: [
              MyAssets.logoSecond.image(width: 130.w, height: 75.h),
              const Gap(20),
              Text(
                context.tr(LocaleKeys.resetYourPassword),
                style: context.textTheme.bodyMedium?.apply(color: Colors.black),
              ),
              const Gap(4),
              Text(
                context.tr(LocaleKeys.pleaseSetNewPasswordMessage),
                style: context.textTheme.bodySmall?.apply(color: context.appColors.subTitle),
              ),
              const Gap(24),
              MainCard(
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        EditFormType.password.title,
                        style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                      ),
                      const Gap(8),
                      HookBuilder(builder: (context) {
                        final hidePassword = useState<bool>(true);
                        return AppTextField(
                          controller: password,
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
                          controller: confirmPassword,
                          // focusNode: focusNode,
                          prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.confirmPassword.icon.svg(width: 16, height: 16)),
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


                      const Gap(40),
                      Row(
                        children: [
                          Expanded(child: HookConsumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final passwordText = useListenableSelector(password, () => password.text);
                            final confirmPasswordText = useListenableSelector(confirmPassword, () => confirmPassword.text);
                            final isEnable = passwordText.isNotEmpty && confirmPasswordText.isNotEmpty;
                            return ButtonWidget(
                              enable: isEnable,
                              onPressed: () {
                                if(passwordText != confirmPasswordText) {
                                  AppToast.failed(message: context.tr(LocaleKeys.passwordNotMatch));
                                  return;
                                }
                                final payload = ResetPasswordPayload(pass: passwordText, requestId: model.requestId ?? '', phoneNumber: model.phonNumber ?? '');
                                ref.read(loginControllerProvider).resetPassword(payload);
                              },
                              text: context.tr(LocaleKeys.confirmButton),
                              textColor: Colors.white,
                              backgroundColor: context.appColors.primary,
                            );
                          }))
                        ],
                      )
                    ],
                  ),
                  borderColor: context.appColors.border,
                  radius: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20))
            ],
          ),
        ),
      ),
    );
  }
}
