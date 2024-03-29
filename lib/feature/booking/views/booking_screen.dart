import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/feature/booking/state/filter_date.dart';
import 'package:borigarn/feature/booking/state/refresh_booking.dart';
import 'package:borigarn/feature/booking/widgets/booking_list.dart';
import 'package:borigarn/feature/home/controller/home_controller.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/main_app_bar.dart';

class BookingScreen extends HookConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(refreshBookingProvider);
    final ScrollController scrollController = useScrollController();
    final locale = ref.read(getLocaleProvider);


    final tabController = useTabController(initialLength: 2);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        return;
      }
      // tabController.refreshProviderWhenTabChanged(tabController.index);
    });
    return Scaffold(
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(
        title: context.tr(LocaleKeys.bookings),
        leftNavigation: const [],
        rightNavigation: const [ActionNavigationType.booking],
        isCenterTitle: true,
        isShowBorder: false,
        callback: (type) => ({

            ref.read(homeControllerProvider).selectDate(context, DateTime.now(), (picked) {
            ref.read(filterDateProvider.notifier).setDate(picked);

            // detail.date = picked;
            // datePicker.value = picked;
            // ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
        },locale)
          //
          // ref.read(homeControllerProvider).selectDate(context, DateTime.now(), (dateTime) => (){
          //   log.e("ONSWR ${dateTime}");
          //   ref.read(filterDateProvider.notifier).setDate(dateTime);
          // }, locale)
        }),
      ),
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [];
        },
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: 38,
              child: TabBar(
                controller: tabController,
                labelStyle: context.textTheme.labelSmall!.apply(color: context.appColors.primary),
                unselectedLabelStyle: context.textTheme.bodySmall!.apply(color: context.appColors.subTitle),
                tabs: [
                  Row(mainAxisSize: MainAxisSize.min, children: [Tab(text: context.tr(LocaleKeys.upComing))]),
                  Row(mainAxisSize: MainAxisSize.min, children: [Tab(text: context.tr(LocaleKeys.past))]),
                ],
                padding: EdgeInsets.zero,
                labelColor: context.appColors.secondary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                indicatorColor: context.appColors.secondary,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  BookingList(tags: [
                    BookingStatusType.allComing,
                    BookingStatusType.waitingEstimate,
                    BookingStatusType.waitingPayment,
                    BookingStatusType.waitConfirm,
                    BookingStatusType.confirmed
                  ]),
                  BookingList(tags: [
                    BookingStatusType.allPast,
                    BookingStatusType.done,
                    BookingStatusType.cancel,
                  ]),
                  // errorNotHaveReview(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
