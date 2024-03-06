import 'package:borigarn/core/datasource/booking_datasource.dart';
import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:borigarn/feature/booking/state/get_booking_indicator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_booking.g.dart';

@riverpod
class GetBooking extends _$GetBooking {
  int _page = 0;
  int _limit = 10;
  @override
  FutureOr<List<BookingModel>> build({required BookingStatusType status}) async {
    if(status == BookingStatusType.allComing || status == BookingStatusType.allPast) {
      _limit = 1000;
    }
    ref.onDispose(() {
      _page = 0;
      _limit = 10;
    });
    final List<BookingModel> models = await ref.watch(bookingDatasourceProvider).getBooking(0,_limit, status);
    return models;
  }

  void checkRequestMoreData(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 10 == 0 && index != 0;
    final pageToRequest = itemPosition ~/ 10;
    if (requestMoreData && pageToRequest > _page) {
      _getMoreData();
    }
  }

  Future<void> _getMoreData() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(getBookingIndicatorProvider(status).notifier).showLoading();
      });
      _page = _page + 1;

      final start = _page * _limit;
      final end = (_page * _limit) + _limit;
      final List<BookingModel> models = await ref.watch(bookingDatasourceProvider).getBooking(start, end, status);
      final List<BookingModel> updatedData = [...state.asData!.value, ...models];
      state = AsyncData(updatedData);
      ref.read(getBookingIndicatorProvider(status).notifier).hideLoading();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(getBookingIndicatorProvider(status).notifier).showError(e);
      });
    }
  }
}