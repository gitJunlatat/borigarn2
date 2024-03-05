// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InboxModel _$InboxModelFromJson(Map<String, dynamic> json) {
  return _InboxModel.fromJson(json);
}

/// @nodoc
mixin _$InboxModel {
  String get modShopId => throw _privateConstructorUsedError;
  String get shopName => throw _privateConstructorUsedError;
  String get modProductId => throw _privateConstructorUsedError;
  String get productImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InboxModelCopyWith<InboxModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxModelCopyWith<$Res> {
  factory $InboxModelCopyWith(
          InboxModel value, $Res Function(InboxModel) then) =
      _$InboxModelCopyWithImpl<$Res, InboxModel>;
  @useResult
  $Res call(
      {String modShopId,
      String shopName,
      String modProductId,
      String productImageUrl});
}

/// @nodoc
class _$InboxModelCopyWithImpl<$Res, $Val extends InboxModel>
    implements $InboxModelCopyWith<$Res> {
  _$InboxModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modShopId = null,
    Object? shopName = null,
    Object? modProductId = null,
    Object? productImageUrl = null,
  }) {
    return _then(_value.copyWith(
      modShopId: null == modShopId
          ? _value.modShopId
          : modShopId // ignore: cast_nullable_to_non_nullable
              as String,
      shopName: null == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      modProductId: null == modProductId
          ? _value.modProductId
          : modProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productImageUrl: null == productImageUrl
          ? _value.productImageUrl
          : productImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InboxModelImplCopyWith<$Res>
    implements $InboxModelCopyWith<$Res> {
  factory _$$InboxModelImplCopyWith(
          _$InboxModelImpl value, $Res Function(_$InboxModelImpl) then) =
      __$$InboxModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String modShopId,
      String shopName,
      String modProductId,
      String productImageUrl});
}

/// @nodoc
class __$$InboxModelImplCopyWithImpl<$Res>
    extends _$InboxModelCopyWithImpl<$Res, _$InboxModelImpl>
    implements _$$InboxModelImplCopyWith<$Res> {
  __$$InboxModelImplCopyWithImpl(
      _$InboxModelImpl _value, $Res Function(_$InboxModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modShopId = null,
    Object? shopName = null,
    Object? modProductId = null,
    Object? productImageUrl = null,
  }) {
    return _then(_$InboxModelImpl(
      modShopId: null == modShopId
          ? _value.modShopId
          : modShopId // ignore: cast_nullable_to_non_nullable
              as String,
      shopName: null == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      modProductId: null == modProductId
          ? _value.modProductId
          : modProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productImageUrl: null == productImageUrl
          ? _value.productImageUrl
          : productImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxModelImpl extends _InboxModel {
  const _$InboxModelImpl(
      {required this.modShopId,
      required this.shopName,
      required this.modProductId,
      required this.productImageUrl})
      : super._();

  factory _$InboxModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxModelImplFromJson(json);

  @override
  final String modShopId;
  @override
  final String shopName;
  @override
  final String modProductId;
  @override
  final String productImageUrl;

  @override
  String toString() {
    return 'InboxModel(modShopId: $modShopId, shopName: $shopName, modProductId: $modProductId, productImageUrl: $productImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxModelImpl &&
            (identical(other.modShopId, modShopId) ||
                other.modShopId == modShopId) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.modProductId, modProductId) ||
                other.modProductId == modProductId) &&
            (identical(other.productImageUrl, productImageUrl) ||
                other.productImageUrl == productImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, modShopId, shopName, modProductId, productImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxModelImplCopyWith<_$InboxModelImpl> get copyWith =>
      __$$InboxModelImplCopyWithImpl<_$InboxModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxModelImplToJson(
      this,
    );
  }
}

abstract class _InboxModel extends InboxModel {
  const factory _InboxModel(
      {required final String modShopId,
      required final String shopName,
      required final String modProductId,
      required final String productImageUrl}) = _$InboxModelImpl;
  const _InboxModel._() : super._();

  factory _InboxModel.fromJson(Map<String, dynamic> json) =
      _$InboxModelImpl.fromJson;

  @override
  String get modShopId;
  @override
  String get shopName;
  @override
  String get modProductId;
  @override
  String get productImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$InboxModelImplCopyWith<_$InboxModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
