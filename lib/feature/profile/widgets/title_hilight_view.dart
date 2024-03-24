import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TitleHighlightView extends StatelessWidget {
  final double width;
  final String wording;

  const TitleHighlightView({super.key, required this.width, required this.wording});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: context.appColors.primary, width: width))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          Flexible(
              child: Text(
            wording.toUpperCase(),
            style: context.textTheme.labelLarge?.apply(color: Colors.black),
          ))
        ],
      ),
    );
  }
}
