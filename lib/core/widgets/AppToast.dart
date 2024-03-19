import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class AppToast {
  final String message;
  final Color? colorFill;
  final Color backgroundColor;
  final Color? textColor;

  AppToast.failed({
    required this.message,
    this.colorFill,
    this.backgroundColor =  const Color(0xFFFF6058),
    this.textColor,
  }) {
    FToast fToast = FToast();
    fToast.init(rootContext()!);
    getFToast(fToast);
  }

  AppToast.success({
    required this.message,
    this.colorFill,
    this.backgroundColor = const Color(0xFF43C58E),
    this.textColor,
  }) {
    FToast fToast = FToast();
    fToast.init(rootContext()!);
    getFToast(fToast);
  }

  Widget get toast => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9.5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: backgroundColor.withOpacity(0.8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(8),
        Flexible(
          child: Text(
            message,
            maxLines: 5,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );

  Function(FToast fToast) get getFToast => (FToast fToast) {
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(milliseconds: 2500),
      gravity: ToastGravity.TOP,
    );
  };
}
