import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';

class AppCheckBoxView extends StatelessWidget {
  final bool isCheck;
  final bool isDisable;
  final void Function(bool) onChange;
  final EdgeInsets tapPadding;

  const AppCheckBoxView({super.key, required this.isCheck, required this.isDisable, required this.onChange, required this.tapPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDisable ? context.appColors.grey150 : Colors.white,
      width: 15,
      height: 15,
      child: Checkbox(
        activeColor: context.appColors.subPrimary ,
        value: isCheck,
        onChanged: (bool? value) {
          if (!isDisable) {
            onChange(value ?? false);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 1.0, color: (isCheck) ? context.appColors.subPrimary : ((isDisable) ? context.appColors.grey200 : Colors.grey)),
        ),
      ),
    );
  }
}
