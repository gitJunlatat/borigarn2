// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceDetailsImpl _$$ServiceDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ServiceDetailsImpl(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      deletedAt: json['deletedAt'] as String?,
      deletedBy: json['deletedBy'] as String?,
      textTh: json['textTh'] as String?,
      textEn: json['textEn'] as String?,
      type: json['type'] as String?,
      order: json['order'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ServiceItemDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String?,
      result1: json['result1'] as String?,
      result2: json['result2'] as String?,
      result3: json['result3'] as String?,
      result4: json['result4'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
      selected: (json['selected'] as List<dynamic>?)
              ?.map(
                  (e) => ServiceItemDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ServiceDetailsImplToJson(
        _$ServiceDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'deletedAt': instance.deletedAt,
      'deletedBy': instance.deletedBy,
      'textTh': instance.textTh,
      'textEn': instance.textEn,
      'type': instance.type,
      'order': instance.order,
      'items': instance.items,
      'result': instance.result,
      'result1': instance.result1,
      'result2': instance.result2,
      'result3': instance.result3,
      'result4': instance.result4,
      'date': instance.date?.toIso8601String(),
      'time': instance.time,
      'selected': instance.selected,
    };
