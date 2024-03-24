// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceItemDetailImpl _$$ServiceItemDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceItemDetailImpl(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
      deletedBy: json['deletedBy'] as String?,
      nameTh: json['nameTh'] as String?,
      nameEn: json['nameEn'] as String?,
      descriptionTh: json['descriptionTh'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      value: json['value'] as int?,
      isPopular: json['isPopular'] as bool?,
      isAppraise: json['isAppraise'] as bool?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$ServiceItemDetailImplToJson(
        _$ServiceItemDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'deletedAt': instance.deletedAt,
      'deletedBy': instance.deletedBy,
      'nameTh': instance.nameTh,
      'nameEn': instance.nameEn,
      'descriptionTh': instance.descriptionTh,
      'descriptionEn': instance.descriptionEn,
      'value': instance.value,
      'isPopular': instance.isPopular,
      'isAppraise': instance.isAppraise,
      'isActive': instance.isActive,
    };
