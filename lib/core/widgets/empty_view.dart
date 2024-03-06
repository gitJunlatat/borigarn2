import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        width: 120.w, height: 120.h,
        decoration: BoxDecoration(
            color: context.appColors.secondaryText,
            shape: BoxShape.circle
        ),
        child: Padding(padding: const EdgeInsets.all(10), child: MyAssets.logoSecond.image(width: 120.w, height: 120.h)),
      ),
    );
  }
}
