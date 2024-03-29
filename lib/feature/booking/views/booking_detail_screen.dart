import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/authen/widgets/main_appbar.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/booking/widgets/booking_card.dart';
import 'package:borigarn/feature/booking/widgets/list_images.dart';
import 'package:borigarn/feature/booking/widgets/payment_detail.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BookingDetailScreen extends ConsumerWidget {
  final BookingModel model;

  const BookingDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.read(getLocaleProvider);

    final status = model.status?.toBookingStatusType() ?? BookingStatusType.system;
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.appColors.light,
        appBar: MainAppBar(
          title: 'Booking no #${model.number}',
          isCenterTitle: true,
          isShowBorder: false,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              const Gap(24).wrapSliver(),
              BookingCard(
                model: model,
                isShowDetail: true,
              ).wrapSliver(),
              const Gap(20).wrapSliver(),
              Text(
                model.service?.getName(locale) ?? '',
                style: context.textTheme.labelLarge?.apply(color: Colors.black),
              ).wrapSliver(),
              const Gap(12).wrapSliver(),
              Divider(
                height: 1,
                color: context.appColors.border,
              ).wrapSliver(),
              const Gap(16).wrapSliver(),
              if (status == BookingStatusType.confirmed || status == BookingStatusType.confirmedPaymentCash)
                PaymentDetail(price:  model.price ?? '0').wrapSliver(),
              if (status != BookingStatusType.confirmed && status != BookingStatusType.confirmedPaymentCash)
                Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          status.title,
                          style: context.textTheme.labelMedium?.apply(color: status.statusColor),
                        ))).wrapSliver(),
              const Gap(16).wrapSliver(),
              Divider(
                height: 1,
                color: context.appColors.border,
              ).wrapSliver(),
              const Gap(20).wrapSliver(),
              if((model.note ?? '').isNotEmpty)
                Text(
                  'Note',
                  style: context.textTheme.labelSmall?.apply(color: Colors.black),
                ).wrapSliver(),
              if((model.note ?? '').isNotEmpty)
                const Gap(12).wrapSliver(),
              if((model.note ?? '').isNotEmpty)
                MainCard(widget: Text(model.note ?? ''), radius: 20, padding: EdgeInsets.all(20), borderColor: context.appColors.border,).wrapSliver(),
      
              if((model.images ?? '').split(',').isNotEmpty)
                ListImages(images: (model.images ?? '').split(','), isLocalImage: false,).wrapSliver(),
              if((model.images ?? '').split(',').isNotEmpty)
                const Gap(24).wrapSliver(),
              Row(
                children: [
                  MyAssets.cancelIcon.svg(width: 24, height: 24),
                  const Gap(12),
                  Text('Cancel or reschedule', style: context.textTheme.labelLarge?.apply(color: Colors.black),)
                ],
              ).wrapSliver(),
              const Gap(10).wrapSliver(),
              Text('Please contact us via\nLINE Official Account: @borigarn\nand inform your booking number', style: context.textTheme.bodySmall?.apply(color: context.appColors.title),).wrapSliver(),
              const Gap(2).wrapSliver(),
              Text('(Example: brg12KL23)', style: context.textTheme.bodySmall?.apply(color: context.appColors.subTitle),).wrapSliver(),
              const Gap(24).wrapSliver(),
      
              ButtonWidget(onPressed: ()  async {
                  String url = 'https://line.me/R/ti/p/%40279dakiw#~';
                  Uri uri = Uri.parse(url);
                  await launchUrl(uri);
              }, text: 'ADD LINE (@borigarn)', textColor: Colors.white, backgroundColor: const Color(0xFF4CAF50)).wrapSliver(),

              const Gap(24).wrapSliver(),

            ],
          ),
        ),
      ),
    );
  }
}


