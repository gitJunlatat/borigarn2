import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/booking/state/get_booking.dart';
import 'package:borigarn/feature/booking/state/refresh_booking.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuccessBookingScreen extends ConsumerWidget {
  final String bookingName;

  const SuccessBookingScreen({super.key, required this.bookingName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyAssets.successBooking.image(width: 220.w, height: 230.h),
            const Gap(12),

            Text(
              context.tr(LocaleKeys.success),
              style: context.textTheme.displayMedium?.apply(color: Colors.black),
            ),
            const Gap(12),
            Text(
              context.tr(LocaleKeys.successMessage),
              style: context.textTheme.titleMedium?.apply(color: Colors.black),
            ),
            Text(
              context.tr(LocaleKeys.successMessage_1),
              style: context.textTheme.titleMedium?.apply(color: Colors.black),
            ),
            Text(
              context.tr(LocaleKeys.successMessage_2, args: ['#$bookingName']),
              style: context.textTheme.titleMedium?.apply(color: Colors.black),
            ),
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: ButtonWidget(text: context.tr(LocaleKeys.myBookingButton),
                      textColor: Colors.white,
                      height: 50,
                      backgroundColor: context.appColors.primary,
                      onPressed: () {
                        ref.invalidate(getBookingProvider);
                        ref.read(goRouterProvider).goNamed('booking');
                      }),
                ),
                const Gap(20),
                Expanded(
                  child: ButtonWidget(text: context.tr(LocaleKeys.home),
                      textColor: context.appColors.primary, height: 50,
                      backgroundColor: context.appColors.primary.withOpacity(0.1),
                      onPressed: () {
                        ref.invalidate(getBookingProvider);
                        ref.read(goRouterProvider).popUntilPath('/home');
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
