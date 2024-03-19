import 'package:borigarn/core/datasource/location_datasource.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_location.g.dart';
@riverpod
Future<List<LocationModel>> getLocation(GetLocationRef ref) async {
  return ref.watch(locationDatasourceProvider).getLocationList();
}

@riverpod
Future<LocationModel?> getLocationDefault(GetLocationDefaultRef ref) async {
  return ref.watch(getLocationProvider).value?.firstWhere((element) => element.isDefault ?? false);
}

@riverpod
Future<bool> deleteLocation(DeleteLocationRef ref, int id) async {
  return ref.watch(locationDatasourceProvider).deleteLocation(id);
}