import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
