import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  SliverToBoxAdapter wrapSliver({EdgeInsetsGeometry padding = const EdgeInsets.all(0)}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: padding,
        child: this,
      ),
    );
  }
}