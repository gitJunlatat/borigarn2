import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/feature/booking/widgets/booking_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/widgets/main_app_bar.dart';

class BookingScreen extends HookConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();

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
        title: 'Bookings',
        leftNavigation: const [],
        rightNavigation: const [ActionNavigationType.booking],
        isCenterTitle: true,
        isShowBorder: false,
        callback: (type) => ({}),
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
                tabs: const [
                  Row(mainAxisSize: MainAxisSize.min, children: [Tab(text: 'Upcoming')]),
                  Row(mainAxisSize: MainAxisSize.min, children: [Tab(text: 'Past')]),
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
