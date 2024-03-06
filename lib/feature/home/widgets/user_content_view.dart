import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UserContentView extends StatelessWidget {
  final String name;
  const UserContentView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome, ${name}', style: context.textTheme.headlineMedium?.apply(color: context.appColors.title),),
          const Gap(4),
          Text('Need some help today?', style: context.textTheme.bodyMedium?.apply(color: context.appColors.subTitle),),
        ],
      ),
    );
  }
}
