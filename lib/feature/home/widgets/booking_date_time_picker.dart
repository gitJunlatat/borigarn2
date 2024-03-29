import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/date.dart';
import 'package:borigarn/feature/home/controller/home_controller.dart';
import 'package:borigarn/feature/home/models/service_detail.dart';
import 'package:borigarn/feature/home/state/booking_payload.dart';
import 'package:borigarn/feature/profile/widgets/title_hilight_view.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingDateTimePicker extends HookConsumerWidget {
  final ServiceDetails detail;

  const BookingDateTimePicker({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(getLocaleProvider);
    final datePicker = useState<DateTime?>(null);
    final timePicker = useState<TimeOfDay?>(null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(24),
          TitleHighlightView(width: 5, wording: detail.getText(locale) ?? ''),
          const Gap(20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (detail.items?[index].nameEn == 'Date') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(((detail.items?[index].getName(locale)) ?? '').toUpperCase(), style: context.textTheme.labelMedium?.apply(color: Colors.black),),
                    const Gap(4),
                    InkWell(
                      onTap: () {
                        final currentDate = datePicker.value ?? DateTime.now();
                        ref.read(homeControllerProvider).selectDate(context, currentDate, (picked) {
                          detail.date = picked;
                          datePicker.value = picked;
                          ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
                        },locale);
                      },
                      child: Container(
                        height: 50.h,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            MyAssets.booking.calendarIcon.svg(width: 24, height: 24),
                            const Gap(20),
                            if (detail.date != null)
                              Text(
                                "${DateFormat('EEEE').format(detail.date!)} - ${DateAction.getDateStringFormatted(detail.date!, locale)} ",
                                style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                              ),
                            if (detail.date == null)
                              Text(
                                ((detail.items?[index].getName(locale)) ?? '').toUpperCase(),
                                style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
                              )
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appColors.border,),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(16),
                    Text(((detail.items?[index].getName(locale)) ?? '').toUpperCase(), style: context.textTheme.labelMedium?.apply(color: Colors.black),),
                    const Gap(4),
                    InkWell(
                      onTap: () {
                        final currentTime = timePicker.value ?? const TimeOfDay(hour: 0, minute: 0);
                        ref.read(homeControllerProvider).selectTime(context, currentTime, (picked) {
                          timePicker.value = picked;
                          detail.time = "${'${picked?.hour}'.padLeft(2, '0')}:${'${picked?.minute}'.padLeft(2, '0')}";
                          ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);

                        }, locale);

                      },
                      child: Container(
                        height: 50.h,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            MyAssets.booking.timeIcon.svg(width: 24, height: 24),
                            const Gap(20),
                            if (detail.time != null)
                              Text(
                                "${detail.time}",
                                style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                              ),
                            if (detail.time == null)
                              Text(
                                ((detail.items?[index].getName(locale)) ?? '').toUpperCase(),
                                style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
                              )
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 1, color: context.appColors.border,),
                  ],
                );
              }
            },
            itemCount: detail.items?.length ?? 0,
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
