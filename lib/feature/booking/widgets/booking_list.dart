import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/widgets/empty_view.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/booking/state/get_booking.dart';
import 'package:borigarn/feature/booking/state/get_booking_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'booking_card.dart';

class BookingList extends HookConsumerWidget {
  final List<BookingStatusType> tags;
  const BookingList({super.key, required this.tags});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterTag = useState<BookingStatusType>(tags.first);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getBookingProvider(status: filterTag.value));
      },
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: Gap(12)),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 40.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (BuildContext context, int index) {
                final isFocus = filterTag.value == tags[index];
                return InkWell(
                  onTap: () {
                    filterTag.value = tags[index];
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: (index == 0) ? 16 : 12, right: (index == tags.length - 1) ? 16 : 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: isFocus ? context.appColors.secondary : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.appColors.secondary, width: 1)),
                      child: Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                              child: Text(
                                tags[index].title,
                                style: context.textTheme.bodyMedium?.apply(color: isFocus ? Colors.white : context.appColors.secondary),
                              ))),
                    ),
                  ),
                );
              },
            ),
          )),
          const SliverToBoxAdapter(child: Gap(12)),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final state = ref.watch(getBookingProvider(status: filterTag.value));
              return state.when(data: (data) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    ref.read(getBookingProvider(status: filterTag.value).notifier).checkRequestMoreData(index);
                    return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: BookingCard(
                          model: data[index],
                        ));
                  },
                  childCount: data.length,
                ));
              }, error: (stack, error) {
                log.e(error);
                return SliverToBoxAdapter(
                    child: SizedBox(
                  width: 1.sw,
                  height: 1.sw,
                  child: const EmptyView(),
                ));
              }, loading: () {
                return const SliverToBoxAdapter(child: ShimmerListLoading());
              });
            },
          )
        ],
      ),
    );
  }
}
