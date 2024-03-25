import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:borigarn/core/widgets/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_photo_view.dart';

class MediaViewScreen extends HookConsumerWidget {
  final int initialPage;
  final List<String> medias;
  final bool isLocalImage;
  const MediaViewScreen({
    super.key,
    required this.medias,
    this.initialPage = 0,
    this.isLocalImage = false
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(initialPage: initialPage);
    final isSingle = medias.length == 1;
    return Scaffold(
      backgroundColor: context.appColors.black,
      appBar: AppBar(
        backgroundColor: context.appColors.black,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: context.appColors.light,
          ),
        ),
        title: Offstage(
          offstage: isSingle,
          child: HookBuilder(builder: (context) {
            final currentPage = useListenableSelector(pageController, () => pageController.page?.round() ?? pageController.initialPage);
            return Container(
              decoration: BoxDecoration(
                color: context.appColors.black.withOpacity(0.16),
                borderRadius: BorderRadius.circular(99),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                "${currentPage + 1}/${medias.length}",
                style: context.textTheme.bodyMedium?.apply(color: context.appColors.light),
              ),
            );
          }),
        ),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          final media = medias[index];
          return AppPhotoView(imageUrl: media, isLocalImage: isLocalImage,);
        },
        controller: pageController,
        itemCount: medias.length,
      ),
      bottomNavigationBar: SafeArea(
        child: HookBuilder(builder: (context) {
          return IgnorePointer(
            ignoring: isSingle || false,
            child: Opacity(
              opacity: isSingle || false ? 0 : 1,
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemBuilder: (context, index) {
                    return HookBuilder(builder: (context) {
                      final currentPage = useListenableSelector(pageController, () => pageController.page?.round() ?? pageController.initialPage);
                      final onFocus = index == currentPage;
                      final media = medias[index];
                      return GestureDetector(
                        onTap: () => pageController.jumpToPage(index),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: onFocus ? context.appColors.primary : Colors.transparent,
                          ),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: AppImageNetwork(
                              imageUrl: media,
                              fit: BoxFit.cover,
                              errorWidget: Container(
                                alignment: Alignment.center,
                                color: context.appColors.backgroundText,
                                child: const SizedBox.square(
                                  dimension: 24,
                                  child: EmptyView(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  itemCount: medias.length,
                  separatorBuilder: (BuildContext context, int index) => const Gap(16),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
