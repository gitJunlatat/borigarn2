import 'dart:ui';

import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum BookingStatusType {
  allComing,
  allPast,

  waitingEstimate,
  waitingPayment,
  waitConfirm,
  confirmed,
  confirmedPaymentCash,
  done,
  cancel,
  system;

  bool get isPast {
    switch(this) {
      case BookingStatusType.done:
      case BookingStatusType.cancel:
        return true;
      default:
        return false;
    }
  }

  String get buttonTitle {
    switch (this) {
      case BookingStatusType.allComing:
      case BookingStatusType.allPast:
      return LocaleKeys.all.tr();
      case BookingStatusType.confirmed:
      case BookingStatusType.confirmedPaymentCash:
      case BookingStatusType.waitingEstimate:
      case BookingStatusType.waitConfirm:
        return LocaleKeys.view.tr();
      case BookingStatusType.waitingPayment:
        return LocaleKeys.pay.tr();
      case BookingStatusType.done:
        return LocaleKeys.done.tr();
      case BookingStatusType.cancel:
        return LocaleKeys.cancelled.tr();
      case BookingStatusType.system:
        return 'System';
    }
  }

  String get title {
    switch (this) {
      case BookingStatusType.allComing:
      case BookingStatusType.allPast:
        return LocaleKeys.all.tr();
      case BookingStatusType.waitingEstimate:
        return LocaleKeys.waitEstimate.tr();
      case BookingStatusType.waitingPayment:
        return LocaleKeys.waitPayment.tr();
      case BookingStatusType.waitConfirm:
        return LocaleKeys.waitConfirm.tr();
      case BookingStatusType.confirmed:
        return LocaleKeys.confirm.tr();
      case BookingStatusType.confirmedPaymentCash:
        return LocaleKeys.confirm.tr();
      case BookingStatusType.done:
        return LocaleKeys.done.tr();
      case BookingStatusType.cancel:
        return LocaleKeys.cancelled.tr();
      case BookingStatusType.system:
        return 'System';
    }
  }


  Color get statusColor {
    switch (this) {
      case BookingStatusType.allComing:
      case BookingStatusType.allPast:
        return Colors.transparent;
      case BookingStatusType.waitingEstimate:
        return rootContext()!.appColors.warning1;
      case BookingStatusType.waitingPayment:
        return rootContext()!.appColors.warning1;
      case BookingStatusType.waitConfirm:
        return rootContext()!.appColors.warning1;
      case BookingStatusType.confirmed:
        return rootContext()!.appColors.primary;
      case BookingStatusType.confirmedPaymentCash:
        return rootContext()!.appColors.primary;
      case BookingStatusType.done:
        return rootContext()!.appColors.success1;
      case BookingStatusType.cancel:
        return rootContext()!.appColors.error1;
      case BookingStatusType.system:
        return rootContext()!.appColors.primary;
    }
  }

  AssetGenImage get inboxIcon {
    switch (this) {
      case BookingStatusType.allComing:
      case BookingStatusType.allPast:
        return MyAssets.status.iconStatusWait;
      case BookingStatusType.waitingEstimate:
        return MyAssets.status.iconStatusWait;
      case BookingStatusType.waitingPayment:
        return MyAssets.status.iconStatusWaitPay;
      case BookingStatusType.waitConfirm:
        return MyAssets.status.iconStatusWait;
      case BookingStatusType.confirmed:
        return MyAssets.status.iconStatusDone;
      case BookingStatusType.confirmedPaymentCash:
        return MyAssets.status.iconStatusDone;
      case BookingStatusType.done:
        return MyAssets.status.iconStatusDone;
      case BookingStatusType.cancel:
        return MyAssets.status.iconStatusCancel;
      case BookingStatusType.system:
        return MyAssets.status.iconStatusSystem;
    }
  }

  String get queryStatus {
    switch (this) {
      case BookingStatusType.waitingEstimate:
        return 'waiting_estimate';
      case BookingStatusType.waitingPayment:
        return 'waiting_payment';
      case BookingStatusType.waitConfirm:
        return 'wait_confirm';
      case BookingStatusType.confirmed:
        return 'confirmed';
      case BookingStatusType.confirmedPaymentCash:
        return 'confirmed_payment_cash';
      case BookingStatusType.done:
        return 'done';
      case BookingStatusType.cancel:
        return 'cancelled';
      default:
        return '';
    }
  }

  String get titleStatus {
    switch (this) {
      case BookingStatusType.waitingEstimate:
      case BookingStatusType.waitingPayment:
      case BookingStatusType.waitConfirm:
      return LocaleKeys.waiting.tr();
      case BookingStatusType.confirmed:
      case BookingStatusType.confirmedPaymentCash:
      return LocaleKeys.confirm.tr();
      case BookingStatusType.done:
        return LocaleKeys.done.tr();
      case BookingStatusType.cancel:
        return LocaleKeys.cancelled.tr();
      default:
        return '';
    }
  }
}

extension BookingStatusTypeExtension on String {
  BookingStatusType toBookingStatusType() {
    switch (this) {
      case 'confirmed':
        return BookingStatusType.confirmed;
      case 'confirmed_payment_cash':
        return BookingStatusType.confirmedPaymentCash;
      case 'waiting_estimate':
        return BookingStatusType.waitingEstimate;
      case 'waiting_payment':
        return BookingStatusType.waitingPayment;
      case 'wait_confirm':
        return BookingStatusType.waitConfirm;
      case 'done':
        return BookingStatusType.done;
      case 'cancelled':
        return BookingStatusType.cancel;
      default:
        return BookingStatusType.system;
    }
  }
}

// case 'confirmed':
// image = require('../../../../assets/icon_status_done.png');
// break;
// case 'confirmed_payment_cash':
// image = require('../../../../assets/icon_status_done.png');
// break;
// case 'waiting_estimate':
// console.log("OHUASUASU");
// image = require('../../../../assets/icon_status_wait.png');
// break;
// case 'waiting_payment':
// image = require('../../../../assets/icon_status_wait_pay.png');
// break;
// case 'wait_confirm':
// image = require('../../../../assets/icon_status_wait.png');
// break;
// case 'done':
// image = require('../../../../assets/icon_status_done.png');
// break;
// case 'cancelled':
// image = require('../../../../assets/icon_status_cancel.png');
// break;
