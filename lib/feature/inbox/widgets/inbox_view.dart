import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/core/utils/date.dart';
import 'package:borigarn/core/widgets/empty_view.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/inbox/state/get_inbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InboxView extends ConsumerWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(getInboxProvider);
      },
      child: Consumer(builder: (context, ref, child) {
        return ref.watch(getInboxProvider).when(
            data: (data) {
              if(data.isEmpty) {
                return Center(
                  child: SizedBox(
                    width: 1.sw,
                    height: 1.sw,
                    child: const EmptyView(),
                  ),
                );
              }
                return ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final inbox = data[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: const BoxDecoration(
                          color: Color(0xFFF3FAFF),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                      child: Row(
                        children: [
                          (inbox.updateStatus ?? '').toBookingStatusType().inboxIcon.image(width: 72.w, height: 72.h),
                          const Gap(20),
                          Expanded(
                            child:
                                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                              Flexible(
                                child: Text(
                                  inbox.nameTh ?? '', maxLines: 2, // Set the maximum number of lines
                                  overflow: TextOverflow.ellipsis, style: context.textTheme.labelLarge?.apply(color: context.appColors.title),
                                ),
                              ),
                              const Gap(8),
                              Text(

                              DateAction.getDateTimeStringFormattedPayload(DateTime.parse(inbox.updatedAt ?? '')),



                                style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                });
                },
            error: (err, stack) => Center(
              child: SizedBox(
                width: 1.sw,
                height: 1.sw,
                child: const EmptyView(),
              ),
            ),
            loading: () => const ShimmerListLoading(count: 6,));
      }),
    );
  }
}
