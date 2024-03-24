import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/home/models/booking_response_model.dart';
import 'package:borigarn/feature/home/models/booking_response_model.dart';
import 'package:borigarn/feature/home/state/get_services.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingCard extends ConsumerWidget {
  final BookingModel model;
  final bool isShowDetail;
  const BookingCard({super.key, required this.model, this.isShowDetail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = model.status?.toBookingStatusType() ?? BookingStatusType.system;

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
            !isShowDetail ? Row(children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: status.statusColor),
              ),
              const Gap(4),
              Text(status.titleStatus, style: context.textTheme.bodySmall?.apply(color: status.statusColor))
            ]) : const SizedBox()
          ]),
          const Gap(15),
          if(!isShowDetail)
            Text(
              context.tr(LocaleKeys.scheduled),
              style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
            ),
          const Gap(5),
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
          const Gap(15),
          if(!isShowDetail)
            Text(
            context.tr(LocaleKeys.location),
            style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
          ),
          const Gap(5),
          Row(
            children: [
              MyAssets.booking.locationIcon.svg(width: 16, height: 16),
              const Gap(8),
              Text(
                model.userLocationId?.address ?? '-',
                maxLines: 1,
                style: context.textTheme.bodyMedium?.apply(color: Colors.black),
              )            ],
          ),
          const Gap(15),
          if(!isShowDetail && !status.isPast)
            Row(
            children: [

              Expanded(
                  child: ButtonWidget(
                    onPressed: () {
                      if(status == BookingStatusType.waitingPayment) {
                        final bookingModel = BookingResponseModel(id: model.id, userLocationId: model.userLocationId?.id, date: model.date, time: model.time, number: model.number, price: int.parse(model.price ?? '0'), userId: model.userId);
                        context.pushNamed(
                            'payment_screen',
                            extra: bookingModel);
                      }else {
                        context.pushNamed(
                            'booking_detail',
                            extra: model);
                      }
                    },
                    text: status.buttonTitle,
                    backgroundColor: context.appColors.primary,
                    textColor: Colors.white,
                  ))
            ],
          ),
          if(!isShowDetail && status.isPast)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(status == BookingStatusType.done)
                  Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        context.pushNamed(
                            'review');
                      },
                      text: context.tr(LocaleKeys.review),
                      backgroundColor: context.appColors.primary,
                      textColor: Colors.white,
                    )),
                if(status == BookingStatusType.done)
                  const Gap(20),
                Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        final allService = ref.read(getServicesProvider).valueOrNull;
                        if(allService == null) { return; }

                        final service = allService.firstWhereOrNull((element) => element.id == model.service?.id);
                        if(service == null) { return; }

                        context.pushNamed(
                            'create_booking',
                            extra: service);
                      },
                      text: context.tr(LocaleKeys.bookAgain),
                      backgroundColor: context.appColors.primary.withOpacity(0.1),
                      textColor: context.appColors.primary,
                    ))
              ],
            ),
        ],
      ),
    );
  }
}
