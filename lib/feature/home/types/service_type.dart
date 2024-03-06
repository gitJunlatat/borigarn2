import 'package:borigarn/gen/assets.gen.dart';

enum ServiceType {
  maidService,
  laundryService,
  airCondition,
  renovate,
  painting,
  tiling,
  defectCheck,
  moving;

  AssetGenImage get image {
    switch(this) {
      case ServiceType.maidService:
        return MyAssets.category.service1RealPic;
      case ServiceType.laundryService:
        return MyAssets.category.service2RealPic;
      case ServiceType.airCondition:
        return MyAssets.category.service3RealPic;
      case ServiceType.renovate:
        return MyAssets.category.service4RealPic;
      case ServiceType.painting:
        return MyAssets.category.service5RealPic;
      case ServiceType.tiling:
        return MyAssets.category.service6RealPic;
      case ServiceType.defectCheck:
        return MyAssets.category.service7RealPic;
      case ServiceType.moving:
        return MyAssets.category.service8RealPic;
    }
  }
}

extension IntExtension on int {
  ServiceType toServiceType() {
    switch(this) {
      case 1:
        return ServiceType.maidService;
      case 2:
        return ServiceType.laundryService;
      case 3:
        return ServiceType.airCondition;
      case 4:
        return ServiceType.renovate;
      case 5:
        return ServiceType.painting;
      case 6:
        return ServiceType.tiling;
      case 7:
        return ServiceType.defectCheck;
      case 8:
        return ServiceType.moving;
      default:
        throw Error();
    }
  }
}