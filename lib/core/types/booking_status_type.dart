import 'package:borigarn/gen/assets.gen.dart';

enum BookingStatusType {
  waitingEstimate,
  waitingPayment,
  waitConfirm,
  confirmed,
  confirmedPaymentCash,
  done,
  cancel;

  AssetGenImage get inboxIcon {
    switch (this) {
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
        throw Error();
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