import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ReviewSuccessScreen extends StatelessWidget {
  final double rating;
  const ReviewSuccessScreen({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(padding: const EdgeInsets.only(right: 16,left: 16,  bottom: 80, top: 16) ,child: ButtonWidget(text: 'GO TO HOMEPAGE', textColor: Colors.white, backgroundColor: context.appColors.primary, onPressed: () {
        context.go('home');
      },)),
      backgroundColor: context.appColors.light,
      appBar: MainAppBar(title: 'Review', leftNavigation: [], isShowBorder: false, isCenterTitle: true,),
      body: CustomScrollView(
        slivers: [
          const Gap(40).wrapSliver(),
          MyAssets.reviewImage.image(width: 200.w, height: 200.h).wrapSliver(),
          const Gap(40).wrapSliver(),
          Center(child: Text('Review Success!', style: context.textTheme.displaySmall?.apply(color: const Color(0xFF1F126B)),)).wrapSliver(),
          const Gap(20).wrapSliver(),
          Center(
            child: RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              ignoreGestures: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {

              },
            ),
          ).wrapSliver(),



        ],
      ),
    );
  }
}
