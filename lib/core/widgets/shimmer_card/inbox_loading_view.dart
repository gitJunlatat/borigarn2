import 'package:borigarn/core/widgets/shimmer_card/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InboxLoadingView extends StatelessWidget {
  const InboxLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Skeleton(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        height: 120,
        width: 1.sw,
      ),
    );
  }
}
