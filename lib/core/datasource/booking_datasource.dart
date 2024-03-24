
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/feature/home/types/payment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:typed_data';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/home/models/booking_response_model.dart';
import 'package:borigarn/feature/home/models/payload/create_booking_payload.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constant/constants.dart';

part 'booking_datasource.g.dart';

@Riverpod(keepAlive: true)
BookingDatasource bookingDatasource(BookingDatasourceRef ref) {
  return BookingDatasourceImpl(ref.watch(networkManagerProvider));
}

abstract class BookingDatasource {
  Future<List<BookingModel>> getBooking(int page, int limit, BookingStatusType status);
  Future<String> getServiceDetail(String id, LanguageType lang);
  Future<BookingResponseModel> createBooking(CreateBookingPayload payload, LanguageType lang);
  Future<Uint8List> getQRCode(int amount);
  Future<bool> confirmPayment(BookingResponseModel payload, PaymentType payment, String? couponCode, String? creditCardId);


}

class BookingDatasourceImpl implements BookingDatasource {
  final NetworkManager networkManager;

  BookingDatasourceImpl(this.networkManager);

  final String appBaseUrl = SERVICE_BASE_URL;
  final String paymentUrl = PAYMENT_URL;

  @override
  Future<String> getServiceDetail(String id, LanguageType lang) async {
    final response = await networkManager.get('/passport/html/${id}/${lang.name}',
        appBaseUrl: appBaseUrl,
        onlyData: false);
    return response as String;
  }

  @override
  Future<List<BookingModel>> getBooking(int page, int limit, BookingStatusType status) async {
    log.e('ON GET BOOKIN G');
    final response = await networkManager.get('/passport/reservations',
        queryParameters: (status == BookingStatusType.allComing || status == BookingStatusType.allPast) ? {
          'limit': page,
          'offset': limit,
          'order': 'updated_at',
        } : {
          'limit': page,
          'offset': limit,
          'order': 'updated_at',
          'status': status.queryStatus,
        },
        appBaseUrl: appBaseUrl,
        onlyData: true);
    final listData = response['items'] as List;
    log.e('ON GET BOOKIN G ${listData.length}');

    final totalList = listData.map((e) => BookingModel.fromJson(e)).toList().reversed.toList();
    if(status == BookingStatusType.allComing) {
      final inCase = [BookingStatusType.waitingEstimate, BookingStatusType.waitingPayment, BookingStatusType.waitConfirm, BookingStatusType.confirmed, BookingStatusType.confirmedPaymentCash];
      return totalList.where((element) => inCase.contains(element.status?.toBookingStatusType())).toList();
    }else if (status == BookingStatusType.allPast) {
      final inCase = [BookingStatusType.done, BookingStatusType.cancel];
      return totalList.where((element) => inCase.contains(element.status?.toBookingStatusType())).toList();
    }else {
      return totalList;
    }
  }

  @override
  Future<BookingResponseModel> createBooking(CreateBookingPayload payload, LanguageType lang) async {
    try {
      final response = await networkManager.post('/passport/create',
          appBaseUrl: appBaseUrl,
          fromJson: BookingResponseModel.fromJson,
          data: {
            'serviceId': payload.serviceId,
            'date': payload.date,
            'time': payload.time,
            'isEstimate': payload.isEstimate,
            'note': payload.note,
            'price': payload.price,
            'remark': payload.remark,
            'userLocationId': payload.userLocationId,
            'images': payload.images,
            'formFields': payload.formFields,
          },
          onlyData: true);
      return response;
    }catch(e) {
      log.e('RESPONSE ${e}');
      rethrow;
    }
  }

  @override
  Future<Uint8List> getQRCode(int amount) async {
    final path = '${(await getTemporaryDirectory()).path}.svg';
    try {
      // final response = await networkManager.post('/payment/promptpay',
      //     data: {
      //     'amount': amount
      //     },
      //     appBaseUrl: paymentUrl,
      //     onlyData: false);
      // final res = response as String;
      // log.e(res);

      var dio = Dio();
      const svgURL = 'https://api.omise.co/charges/chrg_5z6khrvh36r9vvdbppk/documents/docu_5z6khrxtwgbshh6r90s/downloads/9FF652EAD17D3E92';


      final svgDownload = await dio.get(
        svgURL,
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      final replaceWidth = (svgDownload.data as String).replaceAll('width="100%"', '');
      final replaceHeight = (replaceWidth).replaceAll('height="100%"', '');
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.svg';
      File svgFile = File('$appDocPath/$fileName');
      await svgFile.writeAsBytes(utf8.encode(jsonEncode(replaceHeight)));
      final image = await svgToPng(replaceHeight, rootContext()!);

      return image;
    }catch(e) {
      log.e(e);
      rethrow;
    }

  }


  Future<Uint8List> svgToPng(String svgString, BuildContext context) async {
    final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), context);
    final image = await pictureInfo.picture.toImage(1000, 1200);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }

    final pngBytes = byteData.buffer.asUint8List();
    return pngBytes;

  }

  @override
  Future<bool> confirmPayment(BookingResponseModel payload, PaymentType payment, String? couponCode, String? creditCardId) async {
    try {
      final response = await networkManager.post('/passport/reservation/payment',
          appBaseUrl: appBaseUrl,
          data: {
            'reservationId': payload.id,
            'paymentType': payment.payLoadParameter,
            'couponCode': couponCode ?? '',
            'creditCardId': creditCardId ?? 'card_test_5t65vw06xvawl1clr8a',
          },rawResponse: true);
      return true;
    }catch(e) {
      log.e('RESPONSE ${e}');
      rethrow;
    }
  }
}
