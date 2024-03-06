import 'dart:convert';

import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/home/models/campaign_model.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/inbox/model/inbox_model.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constant/constants.dart';

part 'booking_datasource.g.dart';

@Riverpod(keepAlive: true)
BookingDatasource bookingDatasource(BookingDatasourceRef ref) {
  return InboxDatasourceImpl(ref.watch(networkManagerProvider));
}

abstract class BookingDatasource {
  Future<List<BookingModel>> getBooking(int page, int limit, BookingStatusType status);
}

class InboxDatasourceImpl implements BookingDatasource {
  final NetworkManager networkManager;

  InboxDatasourceImpl(this.networkManager);

  final String appBaseUrl = SERVICE_BASE_URL;

  @override
  Future<List<BookingModel>> getBooking(int page, int limit, BookingStatusType status) async {
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
}
