import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewScreen extends HookConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = useState(0.0);
    return Scaffold(
      backgroundColor: context.appColors.light,
      bottomNavigationBar: Container(padding: const EdgeInsets.only(right: 16,left: 16,  bottom: 80, top: 16) ,child: ButtonWidget(text: 'Send your review', textColor: Colors.white, backgroundColor: context.appColors.primary, onPressed: () {
        context.pushNamed('review_success', extra: rating.value);
      },)),
      appBar: MainAppBar(
        title: 'Review',
        isCenterTitle: true,
        isShowBorder: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            const Gap(24).wrapSliver(),
            Center(
                child: Text(
              'What do you think about\nour staff’s work?',
              textAlign: TextAlign.center,
              style: context.textTheme.labelLarge?.apply(color: const Color(0xFF38385E)),
            )).wrapSliver(),
            const Gap(20).wrapSliver(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                  child: MyAssets.status.iconStatusSystem.image(),
                ),
              )
            ]).wrapSliver(),
            const Gap(20).wrapSliver(),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                // allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating.value = newRating;
                },
              ),
            ).wrapSliver(),
            const Gap(20).wrapSliver(),
            MainCard(
              radius: 20,
              padding: const EdgeInsets.all(15),
              borderColor: context.appColors.border,
              widget:  Column(
                children: [
                  Text('What should the provider improve?', style: context.textTheme.labelMedium?.apply(color: context.appColors.title)),
                  // TagView(),
                ],
              ),
            ).wrapSliver(),

            const Gap(20).wrapSliver(),
            Text('What’s your suggestion for the provider?', style: context.textTheme.labelMedium?.apply(color: context.appColors.title),).wrapSliver(),
            const Gap(12).wrapSliver(),
            const AppTextField(hintText: 'Anything for us to notice? \n Eg: Bathroom needs harder clean', maxLine: 4,
            ).wrapSliver(),

          ],
        ),
      ),
    );
  }
}
