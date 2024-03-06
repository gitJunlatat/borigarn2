import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  const Skeleton({super.key, this.width, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: <Color>[
        Colors.grey[300]!,
        Colors.grey[300]!,
        Colors.grey[200]!,
        Colors.grey[300]!,
        Colors.grey[300]!,
      ], stops: const <double>[
        0.0,
        0.35,
        0.5,
        0.65,
        1.0
      ]),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.grey[300]!,
        ),
      ),
    );
  }
}
