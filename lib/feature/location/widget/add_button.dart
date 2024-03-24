import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const AddButton({super.key, required this.callback, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 1.sw,
      child: InkWell(
        onTap: () {
          callback();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            MyAssets.bgAdd.image(width: 1.sw, height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              MyAssets.iconAdd.svg(width: 24, height: 24),
              const Gap(12),
              Text(title, style: context.textTheme.labelSmall?.apply(color: context.appColors.primary),)
            ],)

          ],
        ),
      ),
    );
  }
}
