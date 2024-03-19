import 'package:borigarn/feature/location/datasource/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'pin_location.g.dart';

@riverpod
class PinLocation extends _$PinLocation {
  @override
  LocationPlace build() {
    return LocationPlace(latitude: 13.665954, longitude: 100.4852263, placeName: 'Asiatique Bangkok - เอเชียทีค กรุงเทพมหานคร');
  }

  void setNewLocation(LocationPlace model) {
    state = model;
  }
}
