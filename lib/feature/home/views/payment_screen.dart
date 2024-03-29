
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/app_safe_area.dart';
import 'package:borigarn/core/widgets/group_radio.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/booking/widgets/booking_card2.dart';
import 'package:borigarn/feature/home/controller/home_controller.dart';
import 'package:borigarn/feature/home/models/booking_response_model.dart';
import 'package:borigarn/feature/home/state/get_qrcode.dart';
import 'package:borigarn/feature/home/types/payment_type.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentScreen extends HookConsumerWidget {
  final BookingResponseModel model;

  const PaymentScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethod = useState<PaymentType>(PaymentType.cash);
    final scrollController = useScrollController();
    final couponCode = useState<String?>(null);
    final creditCard = useState<String?>(null);

    void scrollDown(int extent) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + extent,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
    return AppSafeArea(
        widget: Scaffold(
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(
        title: 'Payment',
        isCenterTitle: true,
        isShowBorder: false,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingCard2(
                model: model,
                isShowDetail: true,
              ),
              // const Gap(30),
              // Text(context.tr(LocaleKeys.promotionCode)),
              // const Gap(10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //         child: AppTextField(
              //       hintText: context.tr(LocaleKeys.promotionCodeHere),
              //     )),
              //     Gap(10),
              //     ButtonWidget(
              //       onPressed: () {},
              //       text: context.tr(LocaleKeys.applyButton),
              //       textColor: Colors.white,
              //       height: 50,
              //       width: 0.3.sw,
              //       backgroundColor: context.appColors.primary,
              //     )
              //   ],
              // ),
              const Gap(30),
              Divider(
                height: 1,
                color: context.appColors.border,
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr(LocaleKeys.subTotal),
                    style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                  ),
                  Text(
                    '${model.price ?? 0}',
                    style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                  ),
                ],
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr(LocaleKeys.discount),
                    style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                  ),
                  Text(
                    '${model.price ?? 0}',
                    style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                  ),
                ],
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.tr(LocaleKeys.total),
                    style: context.textTheme.labelLarge?.apply(color: Colors.black),
                  ),
                  Text(
                    '${model.price ?? 0}',
                    style: context.textTheme.labelLarge?.apply(color: Colors.black),
                  ),
                ],
              ),
              const Gap(16),
              Divider(
                height: 1,
                color: context.appColors.border,
              ),
              const Gap(30),
              Text(context.tr(LocaleKeys.choosePaymentMethod)),
              const Gap(15),
              Stack(children: [
                HookConsumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    switch (paymentMethod.value) {
                      case PaymentType.credit_card:
                        return Container();
                      case PaymentType.qr_code:
                        return ref.watch(getQrCodeProvider((model.price ?? 0)*100)).when(data: (data) {
                          scrollDown(100);
                          return Stack(children: [
                            Container(
                                padding: const EdgeInsets.only(left: 70, top: 10),child: Image.memory(data, fit: BoxFit.fill,)),
                          ]);
                        },
                            error: (stack, error) {
                              return const Padding(padding: EdgeInsets.only(top: 120),child: ShimmerListLoading(count: 1,));
                            },
                            loading: () {
                              return const Padding(padding: EdgeInsets.only(top: 120),child: ShimmerListLoading(count: 1,));

                            });
                      case PaymentType.cash:
                        return Container();
                    }
                  },
                ),
                HookConsumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    final allMethod = [PaymentType.credit_card, PaymentType.qr_code, PaymentType.cash];
                    return Container(
                      color: Colors.white,
                      child: GroupRadio(
                          data: allMethod.map((e) => e.title).toList(),
                          selected: paymentMethod.value.title,
                          onChanged: (type) {
                            switch (type.toString()) {
                              case 'Credit/Debit Card':
                                return paymentMethod.value = PaymentType.credit_card;
                              case 'QR Code':
                                paymentMethod.value = PaymentType.qr_code;
                              case 'Pay in cash':
                                paymentMethod.value = PaymentType.cash;
                              default:
                                log.e('nothing');
                            }
                          }),
                    );
                  },
                )
              ],)


              // HookConsumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              //
              // },)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, -2), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(LocaleKeys.total),
                      style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                    ),
                    const Gap(10),
                    Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Text(
                        '฿ ${model.price ?? 0}',
                        style: context.textTheme.bodyLarge?.apply(color: context.appColors.primary),
                      );
                    }),
                  ],
                ),
                ButtonWidget(
                  onPressed: () {
                    ref.read(homeControllerProvider).conformPayment(model, paymentMethod.value, couponCode.value, creditCard.value);
                    // createPayload
                  },
                  text: context.tr(LocaleKeys.confirm).toUpperCase(),
                  backgroundColor: context.appColors.primary,
                  height: 50,
                  width: 120.w,
                  textColor: Colors.white,
                )
              ],
            ),
          )),
    ));

  }
}
