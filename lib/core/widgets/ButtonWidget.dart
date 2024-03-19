import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final double? width;
  final double? height;
  final String? text;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? borderColor;
  final Color? disableBorderColor;
  final Widget? child;
  final double? radius;
  final double? borderWidth;
  final bool? isLoading;
  final bool enable;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ButtonWidget({
    super.key,
    this.backgroundColor,
    this.width,
    this.height = 50,
    this.borderColor,
    this.text,
    this.child,
    this.margin,
    this.padding,
    this.radius,
    this.textColor,
    this.fontSize,
    this.isLoading,
    this.borderWidth,
    this.enable = true,
    required this.onPressed,
    this.textStyle,
    this.disableBorderColor,
    this.disableBackgroundColor,
  });

  Widget loading() {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
    );
  }

  Widget textWidget() {
    return Text(
      text ?? "",
      style: textStyle ?? TextStyle(color: textColor, fontSize: fontSize ?? 14),
      maxLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: margin,
      height: height,
      width: width,
      duration: const Duration(milliseconds: 350),
      child: ElevatedButton(
        onPressed: enable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledForegroundColor: Colors.transparent,
          foregroundColor: backgroundColor?.withOpacity(0.1),
          padding: padding ?? const EdgeInsets.all(0),
          backgroundColor: enable ? backgroundColor ?? context.appColors.light : disableBackgroundColor ?? context.appColors.border,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            side: BorderSide(
              width: borderWidth ?? 0,
              color: enable ? borderColor ?? context.appColors.light : disableBorderColor ?? context.appColors.btnDisable,
            ),
          ),
        ),
        child: (isLoading ?? false) ? loading() : child ?? textWidget(),
      ),
    );
  }
}
