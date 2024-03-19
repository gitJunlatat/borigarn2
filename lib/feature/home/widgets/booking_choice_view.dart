import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/types/select_form_type.dart';
import 'package:borigarn/feature/home/widgets/popular_view.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/manager/network.dart';

class BookingChoiceView extends HookConsumerWidget {
  final ServiceDetails detail;

  const BookingChoiceView({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectType = detail.getFormType();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(children: [
            Container(),
            Flexible(
              child: Text(
                detail.textEn ?? '',
                style: context.textTheme.labelLarge,
                maxLines: 2,
              ),
            )
          ]),
          const Gap(16),
          HookConsumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final selected = useState<List<Service>>([]);
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 110.h,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: detail.items?.length ?? 0,
                  // Change this to the number of items you want to display
                  itemBuilder: (context, index) {
                    final item = detail.items?[index];
                    final isSelect = selected.value.firstWhereOrNull((element) => element.id == item?.id) != null;
                    return InkWell(
                        onTap: () {
                          if (!isSelect) {
                            if (selectType == SelectFormType.choice) {
                              selected.value = [item!];
                            } else if (selectType == SelectFormType.multiChoice) {
                              selected.value = [...selected.value, item!];
                            }
                          } else {
                            selected.value = selected.value.where((element) => element.id != item!.id).whereNotNull().toList();
                          }
                        },
                        child: Stack(
                          children: [
                            if (item?.isPopular ?? false) const Positioned(left: 8, top: 8, child: PopularView()),
                            if (isSelect) Positioned(right: 8, top: 8, child: MyAssets.checkIcon.svg(width: 24, height: 24)),
                            MainCard(
                              borderColor: isSelect ? context.appColors.primary : context.appColors.border,
                              radius: 20,
                              padding: const EdgeInsets.all(15),
                              widget: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text(
                                  item?.nameEn ?? '',
                                  style: context.textTheme.labelMedium?.apply(color: Colors.black),
                                ),
                                Row(
                                  children: [Gap((item?.descriptionEn ?? '').isNotNullEmpty ? 10 : 0)],
                                ),
                                if ((item?.descriptionEn ?? '').isNotNullEmpty)
                                  Text(item?.descriptionEn ?? '', style: context.textTheme.bodySmall?.apply(color: context.appColors.subTitle)),
                              ]),
                            )
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
