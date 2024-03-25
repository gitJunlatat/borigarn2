import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/prefs/prefs.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/feature/home/controller/home_controller.dart';
import 'package:borigarn/feature/home/state/get_campaign.dart';
import 'package:borigarn/feature/home/state/get_services.dart';
import 'package:borigarn/feature/home/state/get_user.dart';
import 'package:borigarn/feature/home/types/service_type.dart';
import 'package:borigarn/feature/home/widgets/popular_view.dart';
import 'package:borigarn/feature/home/widgets/promotion_card.dart';
import 'package:borigarn/feature/home/widgets/user_content_view.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
        // context.pushNamed('login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.light,
      body: RefreshIndicator(
        onRefresh: ()   async {
                ref.invalidate(getServicesProvider);
                ref.invalidate(getCampaignsProvider);
                ref.invalidate(getUserProvider);
                ref.invalidate(getLocationProvider);
            },
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
                    child: InkWell(
                      onTap: () {
                       context.pushNamed('location');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 24,
                            color: Colors.white,
                          ),
                          const Gap(8),
                          Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
                                context.tr(LocaleKeys.yourLocation),
                                style: context.textTheme.bodyMedium?.apply(color: Colors.white),
                              );
                            }, loading: () {
                              return Text(
                                'Loading...',
                                style: context.textTheme.bodyMedium?.apply(color: Colors.white),
                              );
                            });
                          },),

                          const Expanded(child: SizedBox.shrink()),
                          const Icon(Icons.expand_more, size: 24, color: Colors.white)
                        ],
                      ),
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
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return ref.watch(getUserProvider).when(data: (data) {
                            return SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              sliver: UserContentView(
                                name: data.name ?? '',
                              ),
                            );
                          }, error: (stack,error) {
                            return const SizedBox.shrink().wrapSliver();
                          }, loading: () {
                            return const SizedBox.shrink().wrapSliver();
                          });

                        },
                      ),
                      const SliverToBoxAdapter(child: Gap(20)),
                      SliverToBoxAdapter(
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return ref.watch(getCampaignsProvider).when(data: (campaign) {
                              if (campaign.isEmpty) {
                                return const SizedBox();
                              } else {
                                return SizedBox(
                                    height: 150.h,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.only(top: 0),
                                        separatorBuilder: (BuildContext context, int index) => Divider(indent: 20, height: 1, thickness: 1, color: context.appColors.border),
                                        itemCount: campaign.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                              padding: EdgeInsets.only(left: index == 0 ? 16 : 0, right: index == 1 ? 16 : 0),
                                              child: PromotionCard(imageUrl: campaign[index].imageEn ?? ''));
                                        }));
                              }
                            }, error: (stack, error) {
                              return const SizedBox();
                            }, loading: () {
                              return const SizedBox();
                            });

                          },
                        ),
                      ),

                      const SliverToBoxAdapter(child: Gap(20)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                            child: Text(
                              context.tr('ourService'),
                              style: context.textTheme.headlineMedium?.apply(color: context.appColors.title),
                            )),
                      ),
                      const SliverToBoxAdapter(child: Gap(20)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return ref.watch(getServicesProvider).when(data: (data) {
                              if (data.isEmpty) {
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
                                      final serviceType = data[index].id!.toServiceType();
                                      return InkWell(
                                        onTap: () {
                                          ref.read(homeControllerProvider).booking(data[index].deepCopy());
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                          ),
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(0), topRight: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                              child: Stack(children: [
                                                serviceType.image.image(fit: BoxFit.cover, height: 160.h),
                                                if (data[index].isPopular ?? false)
                                                  const Positioned(
                                                    left: 8,
                                                    top: 8,
                                                    child: PopularView()),
                                              ])),
                                        ),
                                      );
                                    },
                                    childCount: data.length,
                                  ),
                                );
                              }
                            }, error: (stack, error) {
                              return const SizedBox().wrapSliver();
                            }, loading: () {
                              return const SizedBox().wrapSliver();
                            });

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
