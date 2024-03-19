

import 'package:borigarn/core/constant/constants.dart';
import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/feature/location/models/payload/select_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'location_datasource.g.dart';

@Riverpod(keepAlive: true)
LocationDatasource locationDatasource(LocationDatasourceRef ref) {
  return LocationDatasourceImpl(ref.watch(networkManagerProvider));
}

abstract class LocationDatasource {

  Future<List<LocationModel>> getLocationList();
  Future<LocationModel> createLocation(SelectLocation location);
  Future<LocationModel> updateLocation(int id, SelectLocation location);
  Future<bool> deleteLocation(int id);
}

class LocationDatasourceImpl implements LocationDatasource {
  final NetworkManager networkManager;

  LocationDatasourceImpl(this.networkManager);

  final String appBaseUrl = SERVICE_MEMBER_URL;
  final String userService = SERVICE_USER_V2_URL;
  final String serviceURL = SERVICE_BASE_URL;



  @override
  Future<List<LocationModel>> getLocationList() async {
    final response =  await networkManager.get('/user-location',
        appBaseUrl: serviceURL,
        onlyData: true);
    final listData = response['items'] as List;
    final totalList = listData.map((e) => LocationModel.fromJson(e)).toList().reversed.toList();
    return totalList;
  }

  @override
  Future<LocationModel> createLocation(SelectLocation location) {
    return networkManager.post('/user-location/create',
        appBaseUrl: serviceURL,
        fromJson: LocationModel.fromJson,
        data: {
        "latitude": '${location.lat}',
          "longitude": '${location.long}',
          "name": location.placeName,
          "address": location.address,
          "customData": location.landmark,
          "isDefault": location.isDefault ? 1 : 0,
        },
        onlyData: true);
  }

  @override
  Future<LocationModel> updateLocation(int id, SelectLocation location) {
    return networkManager.put('/user-location/patch',
        appBaseUrl: serviceURL,
        fromJson: LocationModel.fromJson,
        data: {
          "id": id,
          "latitude": '${location.lat}',
          "longitude": '${location.long}',
          "name": location.placeName,
          "address": location.address,
          "customData": location.landmark,
          "isDefault": location.isDefault ? 1 : 0,
        },
        onlyData: true);
  }

  @override
  Future<bool> deleteLocation(int id) async {
    try {
      log.d('ONDELTE');
      final _ = await networkManager.delete('/user-location/$id',
          appBaseUrl: serviceURL,
          fromJson: LocationModel.fromJson,
          onlyData: false);
      log.d('SUCCESS');
      return true;
    }catch(e) {
      log.d('FALIRD');
      return false;
    }

  }

}
