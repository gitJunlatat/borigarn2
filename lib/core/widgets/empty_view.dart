import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Container(
        width: 100.w, height: 100.h,
        decoration: BoxDecoration(
            color: context.appColors.border,
            shape: BoxShape.circle
        ),
        child: Padding(padding: const EdgeInsets.all(10), child: MyAssets.logoSecond.image(width: 100.w, height: 100.h)),
      ),
    );
  }
}
