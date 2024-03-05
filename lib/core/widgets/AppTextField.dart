import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final bool autoFocus;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onSubmitted;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})? buildCounter;
  final Color? fillColor;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final double borderRadius;
  final Color? enabledBorderColor;
  final Color? disableBorderColor;
  final Color? focusBorderColor;
  final int maxLine;
  final int maxLength;
  final bool enabled;
  final bool obscureText;
  final String? prefixText;
  final TextStyle? prefixStyle;

  const AppTextField({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.contentPadding,
    this.onSubmitted,
    this.onChanged,
    this.textInputAction,
    this.textInputType,
    this.inputFormatter,
    this.suffixIcon,
    this.fillColor,
    this.suffixIconConstraints,
    this.borderRadius = 8,
    this.enabledBorderColor,
    this.disableBorderColor,
    this.focusBorderColor,
    this.maxLine = 1,
    this.maxLength = 120,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.buildCounter,
    this.prefixText,
    this.prefixStyle,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: context.textTheme.bodyMedium,
      onSubmitted: onSubmitted,
      maxLines: maxLine,
      onChanged: onChanged,
      autofocus: autoFocus,
      maxLength: maxLength,
      enabled: enabled,
      obscureText: obscureText,
      scrollPadding: const EdgeInsets.only(bottom: 40),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatter,
      buildCounter: buildCounter,
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        hintText: hintText ?? 'ข้อมูล',
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints ??
            const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
        hintStyle: context.textTheme.bodyMedium?.apply(color: context.appColors.secondaryText),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8.5,
            ),
        filled: true,
        counterText: buildCounter != null ? null : "",
        fillColor: fillColor ?? Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: enabledBorderColor ?? context.appColors.btnDisable,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focusBorderColor ?? const Color(0xFF40A9FF),
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: disableBorderColor ?? context.appColors.btnDisable,
            width: 1,
          ),
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints ??
            const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
      ),
    );
  }
}
