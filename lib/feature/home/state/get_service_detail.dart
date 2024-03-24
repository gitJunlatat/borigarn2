import 'package:borigarn/core/datasource/booking_datasource.dart';
import 'package:borigarn/core/state/get_locale.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_service_detail.g.dart';

@riverpod
Future<String> getServiceDetail(GetServiceDetailRef ref, String id) async {
  return ref.watch(bookingDatasourceProvider).getServiceDetail(id, ref.read(getLocaleProvider));
}
