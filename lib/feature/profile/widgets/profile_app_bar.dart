import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/home/state/get_user.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserProvider).when(data: (data) {
      return Container(
        height: 250 + MediaQuery.of(context).padding.top,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MyAssets.profileBg.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              children: [
                Gap(50),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft:  Radius.circular(20),topRight: Radius.circular(100), bottomRight: Radius.circular(100), bottomLeft: Radius.circular(100)),
                  child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: MainCard(
                        borderColor: context.appColors.primary,
                        widget: AppImageNetwork(
                            fit: BoxFit.cover,
                            imageUrl:
                                data.pictureUrl ?? ''),
                        radius: 88,
                        padding: EdgeInsets.zero),
                  ),
                ),
                Gap(4),
                Text(
                  data.name ?? '',
                  style: context.textTheme.displaySmall?.apply(color: Colors.white),
                ),
                Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 24,
                      color: Colors.white,
                    ),
                    const Gap(8),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        return ref.watch(getLocationDefaultProvider).when(data: (data) {
                          return Flexible(
                            child: Text(
                              maxLines: 2,
                              data?.address ?? '',
                              style: context.textTheme.bodyMedium?.apply(color: Colors.white),
                            ),
                          );
                        }, error: (stack, error) {
                          return Text(
                            'Service Location',
                            style: context.textTheme.bodyMedium?.apply(color: Colors.white),
                          );
                        }, loading: () {
                          return Text(
                            'Loading...',
                            style: context.textTheme.bodyMedium?.apply(color: Colors.white),
                          );
                        });
                      },
                    ),
                  ],
                )
              ],
            );
          },
        ),
      );
    }, error: (error, stack) {
      return const ShimmerListLoading(
        count: 1,
      );
    }, loading: () {
      return const ShimmerListLoading(
        count: 1,
      );
    });
    // final user = ref.watch(userNotifierProvider);
  }

  @override
  Size get preferredSize => const Size.fromHeight(250);
}
