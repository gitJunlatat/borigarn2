import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/feature/home/models/service_detail.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_payload.g.dart';

@riverpod
class BookingPayload extends _$BookingPayload {
  @override
  Service build() {
    ref.onDispose(() {
      log.e('IS DISPOSE');
    });
    return const Service();
  }

  void setPayload(Service payload) {
    state = payload;
  }

  void updatePayloadDetail(ServiceDetails item) {
      final items = state.details ?? [];
      final updateList = items.map((e) => e.id == item.id ? item : e).toList();
      state = state.copyWith(details: updateList);
  }
}
