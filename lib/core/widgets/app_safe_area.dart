import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';

class AppSafeArea extends StatelessWidget {
  final Widget widget;
  const AppSafeArea({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.light,
      child: SafeArea(child: widget,),
    );
  }
}
