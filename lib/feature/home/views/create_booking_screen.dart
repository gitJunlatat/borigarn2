import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/app_safe_area.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/booking/widgets/list_images.dart';
import 'package:borigarn/feature/home/controller/home_controller.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/state/booking_image_picker.dart';
import 'package:borigarn/feature/home/state/booking_payload.dart';
import 'package:borigarn/feature/home/state/get_services.dart';
import 'package:borigarn/feature/home/state/get_user.dart';
import 'package:borigarn/feature/home/types/select_form_type.dart';
import 'package:borigarn/feature/home/widgets/booking_choice_view.dart';
import 'package:borigarn/feature/home/widgets/booking_date_time_picker.dart';
import 'package:borigarn/feature/home/widgets/booking_multi_text_area_view.dart';
import 'package:borigarn/feature/home/widgets/booking_text_area_view.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateBookingScreen extends ConsumerWidget {
  final Service model;

  const CreateBookingScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(getLocaleProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(bookingPayloadProvider.notifier).setPayload(model);
      ref.invalidate(getServicesProvider);
    });

    return AppSafeArea(
      widget: Scaffold(
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
                      if(!model.isMaidService())
                        Text(
                          '${context.tr(LocaleKeys.estimate)}',
                          style: context.textTheme.bodyMedium?.apply(color: context.appColors.title),
                        ),

                      if(model.isMaidService())
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              context.tr(LocaleKeys.cost),
                              style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                            ),
                            const Gap(10),
                            Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                              final payload = ref.watch(bookingPayloadProvider);
                              return Text(
                                '฿ ${payload.getCost()}',
                                style: context.textTheme.bodyLarge?.apply(color: context.appColors.primary),
                              );
                            }),
                          ],
                        ),
                          Text(
                          '*${context.tr(LocaleKeys.excludingDiscount)}',
                          style: context.textTheme.bodyMedium?.apply(color: context.appColors.title),
                        ),
                      ],
                    ),
                    ButtonWidget(
                      onPressed: () {
                        final payload = ref.read(bookingPayloadProvider);
                        final errorMessage = payload.validate(locale);
                        if (errorMessage != null) {
                          final title = locale == LanguageType.th ? "กรุณาระบุข้อมูล" : "Please provide information";
                          ref.read(homeControllerProvider).showMessage(title, errorMessage);
                          return;
                        }
                        final user = ref
                            .read(getUserProvider)
                            .valueOrNull;
                        final location = ref
                            .read(getLocationDefaultProvider)
                            .value;
                        ref.read(homeControllerProvider).createBooking(payload.createPayload(locale, location!.id!), user?.id, locale);
                      },
                      text: context.tr(LocaleKeys.bookNow),
                      backgroundColor: context.appColors.primary,
                      height: 50,
                      width: 120.w,
                      textColor: Colors.white,
                    )
                  ],
                ),
              )),
          backgroundColor: context.appColors.light,
          appBar: MainAppBar(
            title: context.tr(model.getName(locale) ?? ''),
            isCenterTitle: true,
            isShowBorder: true,
            leftNavigation: const [ActionNavigationType.navigationBackManual],
            rightNavigation: const [ActionNavigationType.info],
            callback: (type) {
              if (type == ActionNavigationType.info) {
                context.pushNamed('booking_info', extra: model);
              } else if (type == ActionNavigationType.navigationBackManual) {
                ref.read(bookingPayloadProvider);
                ref.refresh(bookingPayloadProvider);
                ref.invalidate(bookingImagePickerProvider);
                context.pop();
              }
            },
          ),
          body: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final service = ref.watch(bookingPayloadProvider);
              final images = ref.watch(bookingImagePickerProvider);

              return ListView.builder(
                shrinkWrap: true,
                itemCount: (service.details?.length ?? 0) + 1,
                itemBuilder: (BuildContext context, int index) {
                  final details = service.details ?? [];
                  if (index == (service.details?.length ?? 0)) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ListImages(
                        images: images.map((e) => e.path).toList(),
                        isLocalImage: true,
                        addWidget: InkWell(
                          onTap: () {
                            ref.read(homeControllerProvider).imagePicker((p0) => {});
                          },
                          child: MainCard(
                              isAllRadius: true,
                              borderColor: context.appColors.primary,
                              radius: 20,
                              padding: const EdgeInsets.all(0),
                              widget: SizedBox(
                                width: 120.w,
                                height: 120.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyAssets.iconAdd.svg(width: 24, height: 20),
                                    const Gap(10),
                                    Text('Upload image', style: context.textTheme.titleMedium?.apply(color: context.appColors.primary))
                                  ],
                                ),
                              )),
                        ),
                      ),
                    );
                  }
                  switch (details[index].getFormType()) {
                    case SelectFormType.choice:
                      return BookingChoiceView(detail: details[index]);
                    case SelectFormType.multiChoice:
                      return BookingChoiceView(detail: details[index]);
                    case SelectFormType.dateTime:
                      return BookingDateTimePicker(
                        detail: details[index],
                      );
                    case SelectFormType.freeText:
                      return BookingTextAreaView(detail: details[index]);
                    case SelectFormType.multiFreeText:
                      return BookingMultiTextAreaView(detail: details[index]);
                    default:
                      return Container();
                  }
                },
              );
            },
          )),
    );
  }
}
