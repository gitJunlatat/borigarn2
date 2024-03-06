// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_booking_indicator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBookingIndicatorHash() =>
    r'606585c1662608056c0367d7087196c993a80390';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$GetBookingIndicator
    extends BuildlessAutoDisposeNotifier<AsyncValue> {
  late final BookingStatusType type;

  AsyncValue build(
    BookingStatusType type,
  );
}

/// See also [GetBookingIndicator].
@ProviderFor(GetBookingIndicator)
const getBookingIndicatorProvider = GetBookingIndicatorFamily();

/// See also [GetBookingIndicator].
class GetBookingIndicatorFamily extends Family<AsyncValue> {
  /// See also [GetBookingIndicator].
  const GetBookingIndicatorFamily();

  /// See also [GetBookingIndicator].
  GetBookingIndicatorProvider call(
    BookingStatusType type,
  ) {
    return GetBookingIndicatorProvider(
      type,
    );
  }

  @override
  GetBookingIndicatorProvider getProviderOverride(
    covariant GetBookingIndicatorProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getBookingIndicatorProvider';
}

/// See also [GetBookingIndicator].
class GetBookingIndicatorProvider
    extends AutoDisposeNotifierProviderImpl<GetBookingIndicator, AsyncValue> {
  /// See also [GetBookingIndicator].
  GetBookingIndicatorProvider(
    BookingStatusType type,
  ) : this._internal(
          () => GetBookingIndicator()..type = type,
          from: getBookingIndicatorProvider,
          name: r'getBookingIndicatorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBookingIndicatorHash,
          dependencies: GetBookingIndicatorFamily._dependencies,
          allTransitiveDependencies:
              GetBookingIndicatorFamily._allTransitiveDependencies,
          type: type,
        );

  GetBookingIndicatorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final BookingStatusType type;

  @override
  AsyncValue runNotifierBuild(
    covariant GetBookingIndicator notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(GetBookingIndicator Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetBookingIndicatorProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<GetBookingIndicator, AsyncValue>
      createElement() {
    return _GetBookingIndicatorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBookingIndicatorProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBookingIndicatorRef on AutoDisposeNotifierProviderRef<AsyncValue> {
  /// The parameter `type` of this provider.
  BookingStatusType get type;
}

class _GetBookingIndicatorProviderElement
    extends AutoDisposeNotifierProviderElement<GetBookingIndicator, AsyncValue>
    with GetBookingIndicatorRef {
  _GetBookingIndicatorProviderElement(super.provider);

  @override
  BookingStatusType get type => (origin as GetBookingIndicatorProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
