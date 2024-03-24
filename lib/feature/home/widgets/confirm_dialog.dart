import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../types/app_button_dialog_type.dart';

class AppConfirmDialog extends StatelessWidget {
  final String? title;
  final String message;

  final List<AppButtonDialogType> buttons;
  final Function(AppButtonDialogType)? onPressed;

  const AppConfirmDialog({
    super.key,
    required this.buttons,
    this.onPressed, this.title, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            if (title != null)
              Text(
                title ?? "",
                style: context.textTheme.labelMedium?.apply(color: Colors.black),
              ),
            const Gap(4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.apply(color: context.appColors.title),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...buttons.mapIndexed((i, e) {
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: i != 0 ? 10 : 0, right: i==0 ? 10: 0),
                      height: 32,
                      child: ButtonWidget(
                        onPressed: () {
                          context.pop();
                          onPressed?.call(e);
                        },
                        text: e.title(),
                        textColor: e.foregroundColor(),
                        backgroundColor: e.backgroundColor(),
                        textStyle: context.textTheme.bodyMedium?.apply(color: e.foregroundColor()),
                      ),
                    ),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
