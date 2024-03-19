import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/feature/authen/controller/otp_controller.dart';
import 'package:borigarn/feature/authen/state/otp_error_count.dart';
import 'package:borigarn/feature/authen/state/otp_timer.dart';
import 'package:borigarn/feature/authen/state/otp_verify_failed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class OtpTextField extends HookConsumerWidget {
  final TextEditingController otpTextController;
  final FocusNode otpFocusNode;
  const OtpTextField({
    super.key,
    required this.otpTextController,
    required this.otpFocusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(otpControllerProvider);
    final hasFocus = useListenableSelector(otpFocusNode, () => otpFocusNode.hasFocus);
    useListenable(otpTextController);

    return Column(
      children: [
        GestureDetector(
          onTap: () => otpFocusNode.requestFocus(),
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                        hasFocus && otpTextController.text.length == index
                            ? context.appColors.primary
                            : context.appColors.border,
                      ),
                    ),
                    duration: const Duration(milliseconds: 350),
                    child: Text(
                      controller.displayOtpNumber(
                        otpTextController.text,
                        otpFocusNode,
                        index,
                      ),
                      style: TextStyle(
                        color: context.appColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(8);
                },
                itemCount: 4,
              ),
            ),
          ),
        ),

        const Gap(24),
      ],
    );
  }
}
