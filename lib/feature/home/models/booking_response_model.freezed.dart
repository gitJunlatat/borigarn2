// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingResponseModel _$BookingResponseModelFromJson(Map<String, dynamic> json) {
  return _BookingResponseModel.fromJson(json);
}

/// @nodoc
mixin _$BookingResponseModel {
  int? get id => throw _privateConstructorUsedError;
  int? get userLocationId => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  String? get number => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingResponseModelCopyWith<BookingResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingResponseModelCopyWith<$Res> {
  factory $BookingResponseModelCopyWith(BookingResponseModel value,
          $Res Function(BookingResponseModel) then) =
      _$BookingResponseModelCopyWithImpl<$Res, BookingResponseModel>;
  @useResult
  $Res call(
      {int? id,
      int? userLocationId,
      List<String>? images,
      String? date,
      String? time,
      String? number,
      int? price,
      int? userId});
}

/// @nodoc
class _$BookingResponseModelCopyWithImpl<$Res,
        $Val extends BookingResponseModel>
    implements $BookingResponseModelCopyWith<$Res> {
  _$BookingResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userLocationId = freezed,
    Object? images = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? number = freezed,
    Object? price = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userLocationId: freezed == userLocationId
          ? _value.userLocationId
          : userLocationId // ignore: cast_nullable_to_non_nullable
              as int?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingResponseModelImplCopyWith<$Res>
    implements $BookingResponseModelCopyWith<$Res> {
  factory _$$BookingResponseModelImplCopyWith(_$BookingResponseModelImpl value,
          $Res Function(_$BookingResponseModelImpl) then) =
      __$$BookingResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? userLocationId,
      List<String>? images,
      String? date,
      String? time,
      String? number,
      int? price,
      int? userId});
}

/// @nodoc
class __$$BookingResponseModelImplCopyWithImpl<$Res>
    extends _$BookingResponseModelCopyWithImpl<$Res, _$BookingResponseModelImpl>
    implements _$$BookingResponseModelImplCopyWith<$Res> {
  __$$BookingResponseModelImplCopyWithImpl(_$BookingResponseModelImpl _value,
      $Res Function(_$BookingResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userLocationId = freezed,
    Object? images = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? number = freezed,
    Object? price = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$BookingResponseModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userLocationId: freezed == userLocationId
          ? _value.userLocationId
          : userLocationId // ignore: cast_nullable_to_non_nullable
              as int?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingResponseModelImpl extends _BookingResponseModel {
  const _$BookingResponseModelImpl(
      {this.id,
      this.userLocationId,
      final List<String>? images,
      this.date,
      this.time,
      this.number,
      this.price,
      this.userId})
      : _images = images,
        super._();

  factory _$BookingResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingResponseModelImplFromJson(json);

  @override
  final int? id;
  @override
  final int? userLocationId;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? date;
  @override
  final String? time;
  @override
  final String? number;
  @override
  final int? price;
  @override
  final int? userId;

  @override
  String toString() {
    return 'BookingResponseModel(id: $id, userLocationId: $userLocationId, images: $images, date: $date, time: $time, number: $number, price: $price, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userLocationId, userLocationId) ||
                other.userLocationId == userLocationId) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userLocationId,
      const DeepCollectionEquality().hash(_images),
      date,
      time,
      number,
      price,
      userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingResponseModelImplCopyWith<_$BookingResponseModelImpl>
      get copyWith =>
          __$$BookingResponseModelImplCopyWithImpl<_$BookingResponseModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingResponseModelImplToJson(
      this,
    );
  }
}

abstract class _BookingResponseModel extends BookingResponseModel {
  const factory _BookingResponseModel(
      {final int? id,
      final int? userLocationId,
      final List<String>? images,
      final String? date,
      final String? time,
      final String? number,
      final int? price,
      final int? userId}) = _$BookingResponseModelImpl;
  const _BookingResponseModel._() : super._();

  factory _BookingResponseModel.fromJson(Map<String, dynamic> json) =
      _$BookingResponseModelImpl.fromJson;

  @override
  int? get id;
  @override
  int? get userLocationId;
  @override
  List<String>? get images;
  @override
  String? get date;
  @override
  String? get time;
  @override
  String? get number;
  @override
  int? get price;
  @override
  int? get userId;
  @override
  @JsonKey(ignore: true)
  _$$BookingResponseModelImplCopyWith<_$BookingResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
