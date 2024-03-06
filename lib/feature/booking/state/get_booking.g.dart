// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_booking.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBookingHash() => r'8725ec3e042daf53955e23895252c4c8dc13a99e';

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

abstract class _$GetBooking
    extends BuildlessAutoDisposeAsyncNotifier<List<BookingModel>> {
  late final BookingStatusType status;

  FutureOr<List<BookingModel>> build({
    required BookingStatusType status,
  });
}

/// See also [GetBooking].
@ProviderFor(GetBooking)
const getBookingProvider = GetBookingFamily();

/// See also [GetBooking].
class GetBookingFamily extends Family<AsyncValue<List<BookingModel>>> {
  /// See also [GetBooking].
  const GetBookingFamily();

  /// See also [GetBooking].
  GetBookingProvider call({
    required BookingStatusType status,
  }) {
    return GetBookingProvider(
      status: status,
    );
  }

  @override
  GetBookingProvider getProviderOverride(
    covariant GetBookingProvider provider,
  ) {
    return call(
      status: provider.status,
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
  String? get name => r'getBookingProvider';
}

/// See also [GetBooking].
class GetBookingProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetBooking, List<BookingModel>> {
  /// See also [GetBooking].
  GetBookingProvider({
    required BookingStatusType status,
  }) : this._internal(
          () => GetBooking()..status = status,
          from: getBookingProvider,
          name: r'getBookingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBookingHash,
          dependencies: GetBookingFamily._dependencies,
          allTransitiveDependencies:
              GetBookingFamily._allTransitiveDependencies,
          status: status,
        );

  GetBookingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final BookingStatusType status;

  @override
  FutureOr<List<BookingModel>> runNotifierBuild(
    covariant GetBooking notifier,
  ) {
    return notifier.build(
      status: status,
    );
  }

  @override
  Override overrideWith(GetBooking Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetBookingProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetBooking, List<BookingModel>>
      createElement() {
    return _GetBookingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBookingProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBookingRef on AutoDisposeAsyncNotifierProviderRef<List<BookingModel>> {
  /// The parameter `status` of this provider.
  BookingStatusType get status;
}

class _GetBookingProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetBooking,
        List<BookingModel>> with GetBookingRef {
  _GetBookingProviderElement(super.provider);

  @override
  BookingStatusType get status => (origin as GetBookingProvider).status;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
