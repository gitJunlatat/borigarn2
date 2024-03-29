import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/home/models/item_detail.dart';
import 'package:borigarn/feature/home/models/service_detail.dart';
import 'package:borigarn/feature/home/state/booking_payload.dart';
import 'package:borigarn/feature/home/types/select_form_type.dart';
import 'package:borigarn/feature/home/widgets/popular_view.dart';
import 'package:borigarn/feature/profile/widgets/title_hilight_view.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class BookingChoiceView extends HookConsumerWidget {
  final ServiceDetails detail;
  const BookingChoiceView({super.key, required this.detail});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(getLocaleProvider);
    final selectType = detail.getFormType();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),

          TitleHighlightView(width: 5, wording: detail.getText(locale) ?? ''),
          const Gap(16),
          HookConsumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 120.h,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: detail.items?.length ?? 0,
                  // Change this to the number of items you want to display
                  itemBuilder: (context, index) {
                    final item = detail.items![index];
                    final isSelect = detail.selected.map((e) => e.id).contains(item.id);
                    // final isSelect = selected.value.firstWhereOrNull((element) => element.id == item?.id) != null;
                    return InkWell(
                        onTap: () {
                          if (!isSelect) {
                            if (selectType == SelectFormType.choice) {
                              detail.selected = [item];
                            } else if (selectType == SelectFormType.multiChoice) {
                              detail.selected = detail.selected + [item];
                            }
                          } else {
                            detail.selected = detail.selected.where((element) => element.id != item.id).toList();
                          }
                          ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
                        },
                        child: Stack(
                          children: [
                            MainCard(
                              borderColor: isSelect ? context.appColors.primary : context.appColors.border,
                              radius: 20,
                              padding: const EdgeInsets.all(15),
                              widget: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                                Text(
                                  item.getName(locale) ?? '',
                                  style: context.textTheme.labelMedium?.apply(color: Colors.black),
                                ),
                                Row(
                                  children: [Gap((item.getDescription(locale)).isNotNullEmpty ? 10 : 0)],
                                ),
                                if ((item.getDescription(locale)).isNotNullEmpty)
                                  Flexible(child: Text(item.getDescription(locale) ?? '', style: context.textTheme.bodySmall?.apply(color: context.appColors.subTitle))),
                              ]),
                            ),
                            if (item.isPopular ?? false) const Positioned(left: 8, top: 8, child: PopularView()),
                            if (isSelect) Positioned(right: 8, top: 8, child: MyAssets.checkIcon.svg(width: 24, height: 24)),
                          ],
                        ));
                  });
            },
          )
        ],
      ),
    );
  }
}
