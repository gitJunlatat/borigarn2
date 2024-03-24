import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:borigarn/core/datasource/authen_datasource.dart';
import 'package:borigarn/core/datasource/booking_datasource.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/utils/error.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/feature/authen/models/payload/request_otp_payload.dart';
import 'package:borigarn/feature/authen/models/payload/reset_password_payload.dart';
import 'package:borigarn/feature/authen/models/verify_otp_model.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';
import 'package:borigarn/feature/home/models/booking_response_model.dart';
import 'package:borigarn/feature/home/models/payload/create_booking_payload.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/state/booking_payload.dart';
import 'package:borigarn/feature/home/types/app_button_dialog_type.dart';
import 'package:borigarn/feature/home/types/payment_type.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../widgets/confirm_dialog.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
HomeController homeController(HomeControllerRef ref) {
  return HomeController(ref);
}

class HomeController {
  final ProviderRef ref;

  HomeController(this.ref);

  Future<void> booking(Service service) async {

    final locationAvailable = ref.read(getLocationDefaultProvider).value;
    if(locationAvailable == null) {
      showDialog(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.48),
        context: rootContext()!,
        builder: (context) {
          return AppConfirmDialog(
            title: context.tr(LocaleKeys.provideLocation),
            message: '',
            buttons: const [AppButtonDialogType.cancel, AppButtonDialogType.ok],
            onPressed: (buttonType) {
              ref.read(goRouterProvider).pushNamed('location',);
            },
          );
        },
      );
      return;
    }

    final copy = service.copyWith(result: null);
    ref.read(goRouterProvider).pushNamed('create_booking', extra: copy);
  }

  Future<void> selectDate(BuildContext context, DateTime selectedDate, Function(DateTime?) callback, LanguageType lang) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
        barrierLabel: '',
        cancelText: (lang == LanguageType.th) ? 'ยกเลิก' : 'Cancel',
        confirmText: (lang == LanguageType.th) ? 'ยืนยัน' : 'OK'
        );

    if (picked != null) {
      callback(picked);
    }
  }


  Future<void> selectTime(BuildContext context, TimeOfDay selectTime, Function(TimeOfDay?) callback, LanguageType lang) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectTime,
        barrierLabel: '',
        cancelText: (lang == LanguageType.th) ? 'ยกเลิก' : 'Cancel',
        confirmText: (lang == LanguageType.th) ? 'ยืนยัน' : 'OK'
    );
    if (picked != null) {
      if(picked.hour < 9.00 || picked.hour >= 17.00) {
        showMessage('',context.tr(LocaleKeys.outOutBorigarn));
        return;
      }
      callback(picked);
    }

  }

  Future<void> createBooking(CreateBookingPayload payload,LanguageType locale) async {
    EasyLoading.show();
    try {
      final result = await ref.read(bookingDatasourceProvider).createBooking(payload, locale);
      EasyLoading.dismiss();
      ref.read(goRouterProvider).pushNamed('payment_screen', extra: result);
    }catch(e) {
      AppToast.failed(message: e.toError());
      EasyLoading.dismiss();
    }
  }

  Future<void> conformPayment(BookingResponseModel model, PaymentType payment, String? couponCode, String? creditCard) async {
    EasyLoading.show();
    try {
      final result = await ref.read(bookingDatasourceProvider).confirmPayment(model, payment, couponCode, creditCard);
      EasyLoading.dismiss();
      ref.read(goRouterProvider).pushNamed('success_booking_screen', extra: model.number);
    }catch(e) {
      AppToast.failed(message: e.toError());
      EasyLoading.dismiss();
    }
  }


  Future<void> showMessage(String title, String message) async {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.48),
      context: rootContext()!,
      builder: (context) {
        return AppConfirmDialog(
          title: title,
          message: message,
          buttons: const [AppButtonDialogType.ok],
          onPressed: (buttonType) {
          },
        );
      },
    );
  }



}
