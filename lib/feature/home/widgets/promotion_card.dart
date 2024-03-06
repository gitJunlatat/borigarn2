import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromotionCard extends StatelessWidget {
  final String imageUrl;
  const PromotionCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 142.h,
      width: 272.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
      ),
      child: AppImageNetwork(imageUrl: imageUrl)
    );
  }
}
