import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/authen/controller/login_controller.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/profile/types/edit_form_type.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequestOtpScreen extends HookConsumerWidget {
  final AuthenticationOTPType otpFlowType;
  const RequestOtpScreen({super.key, required this.otpFlowType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = useTextEditingController();

    return Scaffold(
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(
        isCenterTitle: true,
        isShowBorder: false,
        leftNavigation: const [ActionNavigationType.navigationBack],
        title: context.tr(LocaleKeys.verification),
        callback: (type) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyAssets.phoneIcon.svg(width: 64.w, height: 64.h),
              const Gap(32),
              Text(
                context.tr(LocaleKeys.requestOTP),
                maxLines: 2,
                style: context.textTheme.labelMedium?.apply(color: Colors.black),
              ),
              const Gap(10),
              Text(
                context.tr(LocaleKeys.requestOTPMessage),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: context.textTheme.bodySmall?.apply(color: context.appColors.subTitle),
              ),
              const Gap(24),
              MainCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      EditFormType.phoneNumber.title,
                      style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                    ),
                    const Gap(8),
                    AppTextField(
                        hintText: EditFormType.phoneNumber.title,
                        controller: controller,
                        prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.phoneNumber.icon.svg(width: 16, height: 16))),
                    const Gap(20),
                    HookBuilder(
                      builder: (BuildContext context) {
                        final phoneNumber = useListenableSelector(controller, () => controller.text);

                        return Row(
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                enable: phoneNumber.isNotEmpty,
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  final payload = RequestOTPPayload(phone: phoneNumber, action: otpFlowType, deviceId: '', uniqueId: '');
                                  ref.read(loginControllerProvider).requestOTP(payload);
                                },
                                text: context.tr(LocaleKeys.confirmButton),
                                textColor: Colors.white,
                                backgroundColor: context.appColors.primary,
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
                radius: 20,
                padding: const EdgeInsets.all(40),
                borderColor: context.appColors.border,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
