import 'dart:ui';

import 'package:borigarn/core/datasource/booking_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_qrcode.g.dart';

@riverpod
Future<Uint8List> getQrCode(GetQrCodeRef ref, int amount) async {
  return ref.watch(bookingDatasourceProvider).getQRCode(amount);
}
