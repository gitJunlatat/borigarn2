import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BookingCard extends StatelessWidget {
  final BookingModel model;
  final bool isShowDetail;
  const BookingCard({super.key, required this.model, this.isShowDetail = false});

  @override
  Widget build(BuildContext context) {
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
                  'Booking no #${model.number ?? ''}',
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
              'Scheduled',
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
            'Location',
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
                      context.pushNamed(
                          'booking_detail',
                          extra: model);
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
                      text: 'Review',
                      backgroundColor: context.appColors.primary,
                      textColor: Colors.white,
                    )),
                if(status == BookingStatusType.done)
                  const Gap(20),
                Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        // context.pushNamed(
                        //     'booking_detail',
                        //     extra: model);
                      },
                      text: 'Book Again',
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
