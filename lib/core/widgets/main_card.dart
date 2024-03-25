
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget widget;
  final EdgeInsets padding;
  final Color background;
  final Color borderColor;
  final double radius;
  final bool isAllRadius;
  const MainCard({super.key, required this.widget, required this.radius, required this.padding, this.background = Colors.white, this.borderColor = Colors.white, this.isAllRadius = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(isAllRadius ? radius : 0) ,topRight: Radius.circular(radius), bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))
      ),
      child: widget,
    );
  }
}
