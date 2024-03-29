
import 'package:borigarn/core/datasource/location_datasource.dart';
import 'package:borigarn/core/models/location_model.dart';
import 'package:borigarn/core/route/app_route.dart';
import 'package:borigarn/core/utils/error.dart';
import 'package:borigarn/core/widgets/AppToast.dart';
import 'package:borigarn/feature/location/models/payload/select_location.dart';
import 'package:borigarn/feature/location/state/get_location.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.g.dart';

@Riverpod(keepAlive: true)
LocationController locationController(LocationControllerRef ref) {
  return LocationController(ref);
}

class LocationController {
  final ProviderRef ref;

  final serviceArea = [
    'Krung Thep Maha Nakhon',
    'Bangkok',
    'กรุงเทพมหานคร',

    'Chang Wat Samut Prakan',
    'Samut Prakan',
    '	สมุทรปราการ',

    'สมุทรสาคร',
    'Chang Wat Samut Sakhon',
    'Samut Sakhon',

    'นครปฐม',
    'Chang Wat Nakhon Pathom',
    'Nakhon Pathom',

    'Nonthaburi',
    'Chang Wat Nakhon Pathom',
    'นนทบุรี',

    'Chang Wat Pathum Thani',
    'Pathum Thani',
    '	ปทุมธานี'
  ];

  LocationController(this.ref);

  Future<void> createLocation(SelectLocation location) async {
    if (location.placeName.isEmpty) {
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.pleaseEnterPlaceName));
      return;
    }

    if(!serviceArea.contains(location.administrativeArea)) {
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.outSideArea));
      return;
    }

    try {
      EasyLoading.show();
      await ref.read(locationDatasourceProvider).createLocation(location);
      ref.invalidate(getLocationProvider);
      EasyLoading.dismiss();

      AppToast.success(message: rootContext()!.tr(LocaleKeys.theAddressCreateSuccess));
      ref.read(goRouterProvider).pop();

    } catch (e) {
      AppToast.failed(message: e.toError());
      EasyLoading.dismiss();
    }
  }

  Future<void> updateLocation(LocationModel? location, SelectLocation select) async {
    if(location == null) {
      return;
    }

    if (select.placeName.isEmpty) {
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.pleaseEnterPlaceName));
      return;
    }

    if(!serviceArea.contains(select.administrativeArea)) {
      AppToast.failed(message: rootContext()!.tr(LocaleKeys.outSideArea));
      return;
    }

    try {
      EasyLoading.show();
      await ref.read(locationDatasourceProvider).updateLocation(location!.id!, select);
      ref.invalidate(getLocationProvider);
      EasyLoading.dismiss();

      AppToast.success(message: rootContext()!.tr(LocaleKeys.theAddressCreateSuccess));
      ref.read(goRouterProvider).pop();

    } catch (e) {
      AppToast.failed(message: e.toError());
      EasyLoading.dismiss();
    }
  }

}
