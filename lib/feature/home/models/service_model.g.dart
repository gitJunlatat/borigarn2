// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
      deletedBy: json['deletedBy'] as String?,
      nameTh: json['nameTh'] as String?,
      nameEn: json['nameEn'] as String?,
      isPopular: json['isPopular'] as bool?,
      isActive: json['isActive'] as bool?,
      customData: json['customData'] as String?,
      descriptionTh: json['descriptionTh'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => ServiceDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String?,
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
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
      'isPopular': instance.isPopular,
      'isActive': instance.isActive,
      'customData': instance.customData,
      'descriptionTh': instance.descriptionTh,
      'descriptionEn': instance.descriptionEn,
      'details': instance.details,
      'result': instance.result,
    };
