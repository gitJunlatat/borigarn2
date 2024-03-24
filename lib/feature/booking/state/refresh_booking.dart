import 'package:borigarn/core/manager/network.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_booking.g.dart';
@riverpod
bool refreshBooking(RefreshBookingRef ref) {
  ref.onDispose(() {
    log.e('REFRESH BOOKING');
  });
  return false;
}
