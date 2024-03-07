import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/prefs/prefs.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/feature/home/state/get_campaign.dart';
import 'package:borigarn/feature/home/state/get_services.dart';
import 'package:borigarn/feature/home/types/service_type.dart';
import 'package:borigarn/feature/home/widgets/promotion_card.dart';
import 'package:borigarn/feature/home/widgets/user_content_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(!SharedPrefs().isAuthentication()) {
        context.pushNamed('login');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const ProfileAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => ({}),
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  color: context.appColors.primary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 24,
                          color: Colors.white,
                        ),
                        const Gap(8),
                        Text(
                          'Bangkok, Thailand',
                          style: context.textTheme.bodyMedium?.apply(color: Colors.white),
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        const Icon(Icons.expand_more, size: 24, color: Colors.white)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 120),
                  decoration: BoxDecoration(
                    color: context.appColors.light,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    child: CustomScrollView(slivers: [
                      const SliverToBoxAdapter(child: Gap(20)),
                      const SliverPadding(
                        sliver: UserContentView(
                          name: 'Yothin Junlatat',
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      const SliverToBoxAdapter(child: Gap(20)),
                      SliverToBoxAdapter(
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final campaign = ref.watch(getCampaignsProvider).value;
                            if ((campaign?.length ?? 0) == 0) {
                              return const SizedBox();
                            } else {
                              return SizedBox(
                                  height: 150.h,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(top: 0),
                                      separatorBuilder: (BuildContext context, int index) => Divider(indent: 20, height: 1, thickness: 1, color: context.appColors.border),
                                      itemCount: campaign!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                            padding: EdgeInsets.only(left: index == 0 ? 16 : 0, right: index == 1 ? 16 : 0),
                                            child: PromotionCard(imageUrl: campaign[index].imageEn ?? ''));
                                      }));
                            }
                          },
                        ),
                      ),

                      const SliverToBoxAdapter(child: Gap(20)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                            child: Text(
                              'Our Services',
                              style: context.textTheme.titleLarge?.apply(color: context.appColors.title),
                            )),
                      ),
                      const SliverToBoxAdapter(child: Gap(20)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final services = ref.watch(getServicesProvider).value;
                            if ((services?.length ?? 0) == 0) {
                              return const SliverToBoxAdapter(child: SizedBox());
                            } else {
                              return SliverGrid(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 160.h,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 15,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  // addSemanticIndexes: true,
                                      (BuildContext context, int index) {
                                    final serviceType = services[index].id!.toServiceType();
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                      ),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                          child: Stack(children: [
                                            serviceType.image.image(fit: BoxFit.cover, height: 160.h),
                                            Positioned(
                                                left: 8,
                                                top: 8,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: context.appColors.error1,
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                        'Popular',
                                                        style: context.textTheme.bodySmall?.apply(color: Colors.white),
                                                      )),
                                                )),
                                          ])),
                                    );
                                  },
                                  childCount: services!.length,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const Gap(24).wrapSliver(),
                    ]),
                  ),
                )
              ],
            )),
      ),
    );
  }

}
