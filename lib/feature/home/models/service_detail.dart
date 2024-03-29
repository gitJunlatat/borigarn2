import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/feature/home/models/item_detail.dart';
import 'package:borigarn/feature/home/types/select_form_type.dart';
import 'package:borigarn/feature/home/types/service_type.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'service_detail.freezed.dart';
part 'service_detail.g.dart';


@unfreezed
class ServiceDetails with _$ServiceDetails {
  ServiceDetails._();
  factory ServiceDetails(
      {
        int? id,
        String? createdAt,
        String? updatedAt,
        String? createdBy,
        String? updatedBy,
        String? deletedAt,
        String? deletedBy,
        String? textTh,
        String? textEn,
        String? type,
        int? order,
        List<ServiceItemDetail>? items,
        String? result,
        String? result1,
        String? result2,
        String? result3,
        String? result4,

        DateTime? date,
        String? time,

        @Default([])List<ServiceItemDetail> selected,

      }) = _ServiceDetails;

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => _$ServiceDetailsFromJson(json);

  String? getText(LanguageType type) {
    if(type == LanguageType.en) {
      return textEn;
    }else {
      return textTh;
    }
  }

  SelectFormType getFormType() {
    switch(type) {
      case 'multi_choice':
        return  SelectFormType.multiChoice;
      case 'choice':
        return  SelectFormType.choice;
      case 'text_area':
        return SelectFormType.freeText;
      case 'date_time':
        return SelectFormType.dateTime;
      case 'multi_text_area':
        return SelectFormType.multiFreeText;
      default:
        log.e(type);
        return throw Error();
    }
  }

  ServiceDetails deepCopy() {
    return copyWith(
        items: items,
        result: result,
        selected: selected
    );
  }

}