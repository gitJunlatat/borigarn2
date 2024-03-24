import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_detail.freezed.dart';
part 'item_detail.g.dart';

@freezed
class ServiceItemDetail with _$ServiceItemDetail {
  const ServiceItemDetail._();
  const factory ServiceItemDetail(
      {
        int? id,
        String? createdAt,
        String? updatedAt,
        String? createdBy,
        String? updatedBy,
        String? deletedAt,
        String? deletedBy,
        String? nameTh,
        String? nameEn,
        String? descriptionTh,
        String? descriptionEn,
        int? value,
        bool? isPopular,
        bool? isAppraise,
        bool? isActive,
      }) = _ServiceItemDetail;

  factory ServiceItemDetail.fromJson(Map<String, dynamic> json) => _$ServiceItemDetailFromJson(json);

  String? getName(LanguageType type) {
    if(type == LanguageType.en) {
      return nameEn;
    }else {
      return nameTh;
    }
  }

  String? getDescription(LanguageType type) {
    if(type == LanguageType.en) {
      return descriptionEn;
    }else {
      return descriptionTh;
    }
  }

}


