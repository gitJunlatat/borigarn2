import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';

class AppBottomButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const AppBottomButton({super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 10, left: 16, right: 16),
      child: ButtonWidget(
        onPressed: () {
          callback();
        },
        text: title,
        height: 50,
        radius: 12,
        backgroundColor: context.appColors.primary,
        textColor: Colors.white,
      ),
    );
  }
}
