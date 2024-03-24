import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class RadioListTileWidget extends StatelessWidget {
  Function onChanged;
  dynamic value;
  dynamic groupValue;
  String text;
  TextStyle? textStyle;
  EdgeInsetsGeometry? contentPadding;
  bool enableSeparator;
  Color? separatorColor;
  double? separatorHeight;

  RadioListTileWidget({
    super.key,
    required this.onChanged,
    required this.value,
    required this.groupValue,
    required this.text,
    this.textStyle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.enableSeparator = false,
    this.separatorColor,
    this.separatorHeight = 1
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: value,
          dense: true,
          visualDensity: const VisualDensity(
            horizontal: -4,
            vertical: -4,
          ),
          groupValue: groupValue,
          onChanged: (value) => onChanged(value),
          fillColor: MaterialStateColor.resolveWith(
                (states) {
              return states.isEmpty ? context.appColors.btnDisable : context.appColors.primary;
            },
          ),
          contentPadding: contentPadding,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            text,
            style: textStyle ?? AppTextStyles.defaultTextStyle.copyWith(
              color: Colors.black.withOpacity(0.85),
            ),
          ),
        ),
        if (enableSeparator == true)
          Divider(
            height: separatorHeight,
            color: separatorColor ?? context.appColors.border,
          ),
      ],
    );
  }
}
