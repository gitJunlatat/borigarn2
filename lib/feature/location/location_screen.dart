import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/core/widgets/empty_view.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/feature/location/widget/add_button.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/manager/network.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.appColors.light,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10, left: 16, right: 16),
            child: AddButton(title: context.tr(LocaleKeys.addPlace),callback: () {
              context.pushNamed('edit_location');
            },),
          ),
          backgroundColor: context.appColors.light,
          appBar: MainAppBar(
            title: context.tr(LocaleKeys.myPlace),
            isCenterTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(getLocationProvider);
            },
            child: CustomScrollView(
              slivers: [
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return ref.watch(getLocationProvider).when(data: (data) {
                      List<LocationModel> listData = data;
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final location = listData[index];

                          final isLast = index == listData.length - 1;

                          return Dismissible(
                            key: Key(location.id.toString() ?? ''),
                            onDismissed: (direction) async {
                              listData.removeAt(index);
                              EasyLoading.show();
                              final result = await ref.watch(deleteLocationProvider(location.id!).future);

                              log.e(result);
                              if (result == true) {
                                AppToast.success(message: rootContext()!.tr(LocaleKeys.deleteLocationMessage));
                                ref.invalidate(getLocationProvider);
                                EasyLoading.dismiss();
                              } else {
                                AppToast.failed(message: rootContext()!.tr(LocaleKeys.deleteLocationUnSuccessMessage));
                                ref.invalidate(getLocationProvider);
                                EasyLoading.dismiss();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: isLast ? 20 : 0),
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed('edit_location', extra: location);
                                },
                                child: MainCard(
                                    borderColor: context.appColors.primary,
                                    background: location.isDefault ?? false ? context.appColors.primary.withOpacity(0.1) : Colors.transparent,
                                    radius: 20,
                                    padding: const EdgeInsets.all(20),
                                    widget: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  location.name ?? '',
                                                  maxLines: 2,
                                                  style: context.textTheme.labelLarge?.apply(color: context.appColors.primary),
                                                )),
                                            if (location.isDefault ?? false)
                                              Text(
                                                context.tr(LocaleKeys.defaultWord),
                                                style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),
                                              ),
                                            const Gap(16),
                                            MyAssets.editIcon.svg(width: 24, height: 24)
                                          ],
                                        ),
                                        const Gap(16),
                                        Row(children: [
                                          Flexible(child: Text(location.address ?? '', style: context.textTheme.bodyMedium?.apply(color: context.appColors.title), textAlign: TextAlign.start))
                                        ])
                                      ],
                                    )),
                              ),
                            ),
                          );
                        },
                        childCount: data.length,
                      ));
                    }, error: (stack, error) {
                      return SliverFillRemaining(
                        child: SizedBox(
                          width: 1.sw,
                          height: 1.sw,
                          child: const EmptyView(),
                        ),
                      );
                    }, loading: () {
                      return const SliverToBoxAdapter(child: ShimmerListLoading());
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
