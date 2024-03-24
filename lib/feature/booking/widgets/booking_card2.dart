import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/home/models/booking_response_model.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingCard2 extends ConsumerWidget {
  final BookingResponseModel model;
  final bool isShowDetail;
  const BookingCard2({super.key, required this.model, this.isShowDetail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isShowDetail ? const Color(0xFFE9F7FF) : Colors.white,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
          border: Border.all(color: isShowDetail ? context.appColors.primary : context.appColors.border, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: Text(
                  '${context.tr(LocaleKeys.bookingNo)} #${model.number ?? ''}',
                  style: context.textTheme.labelMedium?.apply(color: isShowDetail ? context.appColors.primary : Colors.black),
                  maxLines: 2,
                )),
          ]),
          const Gap(20),
          Row(
            children: [
              MyAssets.booking.calendarIcon.svg(width: 16, height: 16),
              const Gap(8),
              Text(
                '${model.date}  -  ${model.time}',
                style: context.textTheme.bodyMedium?.apply(color: Colors.black),
              )
            ],
          ),

          const Gap(12),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final address = ref.read(getLocationDefaultProvider).value?.address;
              return Row(
                children: [
                  MyAssets.booking.locationIcon.svg(width: 16, height: 16),
                  const Gap(8),
                  Text(
                    address ?? '',
                    maxLines: 1,
                    style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                  )            ],
              );
            },
          ),
          const Gap(4),

        ],
      ),
    );
  }
}
