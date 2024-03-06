import 'package:borigarn/core/widgets/shimmer_card/inbox_loading_view.dart';
import 'package:flutter/material.dart';

class ShimmerListLoading extends StatelessWidget {
  final int count;
  final bool hasMarginTop;
  const ShimmerListLoading({
    super.key,
    this.count = 4,
    this.hasMarginTop = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) => const InboxLoadingView()
    );
  }
}
