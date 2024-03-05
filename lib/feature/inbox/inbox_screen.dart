import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/feature/inbox/state/get_inbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: Consumer(builder: (context, ref, child) {
        return ref.watch(getInboxProvider).when(data: (data) =>
            ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3FAFF),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Row(
                    children: [
                      'done'.toBookingStatusType().inboxIcon.image(width: 72.w, height: 72.h),
                      Gap(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('The app has somethin', maxLines: 2, // Set the maximum number of lines
                            overflow: TextOverflow.ellipsis, style: context.textTheme.labelLarge?.apply(color: context.appColors.title),),
                          Gap(8),
                          Text('12/05 54', style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),)
                        ]

                      )
                    ],
                  ),
                ),
              ),
            )
            ,
            error: (err, stack) => Text('error'),
            loading: () => Text('load'));
      }),
    );
  }
}
