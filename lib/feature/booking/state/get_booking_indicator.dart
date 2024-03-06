import 'package:borigarn/core/types/booking_status_type.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_booking_indicator.g.dart';

@riverpod
class GetBookingIndicator extends _$GetBookingIndicator{
  @override
  AsyncValue build(BookingStatusType type) {
    return const AsyncData(null);
  }

  void showLoading() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = const AsyncLoading();
    });
  }

  void showError(dynamic error) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = AsyncError(error, StackTrace.empty);
    });

  }

  void hideLoading() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      state = const AsyncData(null);
    });
  }
}
