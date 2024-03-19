import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/utils/date.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/authen/controller/otp_controller.dart';
import 'package:borigarn/feature/authen/models/otp_model.dart';
import 'package:borigarn/feature/authen/models/request_otp_model.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/verify_otp_payload.dart';
import 'package:borigarn/feature/authen/state/otp_error_count.dart';
import 'package:borigarn/feature/authen/state/otp_ref_id.dart';
import 'package:borigarn/feature/authen/state/otp_timer.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/authen/widgets/otp_text_field.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class VerifyOtpScreen extends HookConsumerWidget {
  final RequestOTPModel model;
  final AuthenticationOTPType otpFlowType;

  const VerifyOtpScreen({
    super.key,
    required this.model,
    required this.otpFlowType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(otpControllerProvider);
    final TextEditingController otpTextController = useTextEditingController();
    final FocusNode otpFocusNode = useFocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      otpFocusNode.requestFocus();
      ref.read(otpRefIdProvider.notifier).setRefId(OTPModel(model.requestId ?? '', model.refCode ?? ''));
    });

    return Scaffold(
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(
        title: 'Verification Code',
        isCenterTitle: true,
        isShowBorder: false,
        leftNavigation: const [ActionNavigationType.navigationBack],
        callback: (type) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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
          MyAssets.phoneIcon.svg(width: 64.w, height: 64.h),
          const Gap(20),
          Text(
            'Verify',
            maxLines: 2,
            style: context.textTheme.labelLarge?.apply(color: Colors.black),
          ),
          const Gap(10),
          Text(
            'Please enter the phone number. \n We will send an otp code to your phone number',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.apply(color: context.appColors.subTitle),
          ),

          const Gap(24),

          Offstage(
            offstage: true,
            child: Builder(builder: (context) {
              final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
                mask: '####',
                filter: {
                  "#": RegExp(r'[0-9]'),
                },
                type: MaskAutoCompletionType.lazy,
              );
              return AppTextField(
                textInputType: TextInputType.number,
                focusNode: otpFocusNode,
                inputFormatter: [maskFormatter],
                controller: otpTextController,
                maxLength: 4,
              );
            }),
          ),

          MainCard(
            radius: 20,
            borderColor: context.appColors.border,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            widget: Column(
              children: [
                OtpTextField(
                  otpTextController: otpTextController,
                  otpFocusNode: otpFocusNode,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final otpRef = ref.watch(otpRefIdProvider);
                        return Text(
                          'REF Code : ${otpRef.refCode}',
                          style: context.textTheme.bodySmall?.apply(color: Colors.black),
                        );
                      },
                    ),
                    const Gap(4),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final timeLeft = ref.watch(otpTimerProvider);
                        final hasReachedMaxError = ref.watch(otpErrorCountProvider.select((value) => value >= 3));
                        if (hasReachedMaxError) {
                          return InkWell(
                            onTap: () {
                              final payload = RequestOTPPayload(phone: model.phoneNumber ?? '', action: otpFlowType, deviceId: '', uniqueId: '');
                              controller.renewOtp(payload: payload, otpTextController: otpTextController);
                            },
                            child: Text(
                              "Resend your code",
                              style: context.textTheme.bodyMedium?.apply(
                                color: context.appColors.subPrimary,
                              ),
                            ),
                          );
                        }
                        if (timeLeft == 0) {
                          return RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Resend your code',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      final payload = RequestOTPPayload(phone: model.phoneNumber ?? '', action: otpFlowType, deviceId: '', uniqueId: '');
                                      controller.renewOtp(payload: payload, otpTextController: otpTextController);
                                    },
                                  style: context.textTheme.bodySmall?.apply(
                                    color: context.appColors.subPrimary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: context.textTheme.bodySmall?.apply(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Expired after',
                                style: context.textTheme.bodySmall?.apply(
                                  color: context.appColors.subTitle,
                                ),
                              ),
                              TextSpan(
                                text: ' $timeLeft s ',
                                style: context.textTheme.bodySmall?.apply(
                                  color: context.appColors.subTitle,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(24),
                HookConsumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    final otpCode = useListenableSelector(otpTextController, () => otpTextController.text);
                    return Row(
                      children: [Expanded(
                        child: ButtonWidget(onPressed: () {
                          final newOtpModel = ref.read(otpRefIdProvider);
                          model.refCode = newOtpModel.refCode;
                          model.requestId = newOtpModel.requestId;
                          final verifyPayload = VerifyOTPPayload(requestModel: model, otpCode: otpCode, action: otpFlowType);
                          ref.read(otpControllerProvider).verifyOtp(payload: verifyPayload);
                        },
                          text: 'CONFIRM',
                          height: 50,
                          backgroundColor: context.appColors.primary,
                          textColor: Colors.white,
                          enable: otpCode.length == 4,
                        ),
                      )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
          ],
        ),
      ),
    ),);
  }
}
