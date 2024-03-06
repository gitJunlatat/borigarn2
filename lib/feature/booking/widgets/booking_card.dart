import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BookingCard extends StatelessWidget {
  final BookingModel model;
  const BookingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final status = model.status?.toBookingStatusType() ?? BookingStatusType.system;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
          border: Border.all(color: context.appColors.border, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: Text(
                  'Booking no #${model.number ?? ''}',
                  style: context.textTheme.labelMedium?.apply(color: Colors.black),
                  maxLines: 2,
                )),
            Row(children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: status.statusColor),
              ),
              const Gap(4),
              Text(status.titleStatus, style: context.textTheme.bodySmall?.apply(color: status.statusColor))
            ])
          ]),
          const Gap(15),
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
          Row(
            children: [
              Expanded(
                  child: ButtonWidget(
                    onPressed: () {},
                    text: 'View',
                    backgroundColor: context.appColors.primary,
                    textColor: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
