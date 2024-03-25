// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingResponseModelImpl _$$BookingResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingResponseModelImpl(
      id: json['id'] as int?,
      userLocationId: json['userLocationId'] as int?,
      images: json['images'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      number: json['number'] as String?,
      price: json['price'] as int?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$$BookingResponseModelImplToJson(
        _$BookingResponseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userLocationId': instance.userLocationId,
      'images': instance.images,
      'date': instance.date,
      'time': instance.time,
      'number': instance.number,
      'price': instance.price,
      'userId': instance.userId,
    };
