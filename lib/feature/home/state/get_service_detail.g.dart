// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_detail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getServiceDetailHash() => r'028287f8caf18120b2cdcb311dc9d4dda2549af0';

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

/// See also [getServiceDetail].
@ProviderFor(getServiceDetail)
const getServiceDetailProvider = GetServiceDetailFamily();

/// See also [getServiceDetail].
class GetServiceDetailFamily extends Family<AsyncValue<String>> {
  /// See also [getServiceDetail].
  const GetServiceDetailFamily();

  /// See also [getServiceDetail].
  GetServiceDetailProvider call(
    String id,
  ) {
    return GetServiceDetailProvider(
      id,
    );
  }

  @override
  GetServiceDetailProvider getProviderOverride(
    covariant GetServiceDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'getServiceDetailProvider';
}

/// See also [getServiceDetail].
class GetServiceDetailProvider extends AutoDisposeFutureProvider<String> {
  /// See also [getServiceDetail].
  GetServiceDetailProvider(
    String id,
  ) : this._internal(
          (ref) => getServiceDetail(
            ref as GetServiceDetailRef,
            id,
          ),
          from: getServiceDetailProvider,
          name: r'getServiceDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getServiceDetailHash,
          dependencies: GetServiceDetailFamily._dependencies,
          allTransitiveDependencies:
              GetServiceDetailFamily._allTransitiveDependencies,
          id: id,
        );

  GetServiceDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<String> Function(GetServiceDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetServiceDetailProvider._internal(
        (ref) => create(ref as GetServiceDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _GetServiceDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetServiceDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetServiceDetailRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetServiceDetailProviderElement
    extends AutoDisposeFutureProviderElement<String> with GetServiceDetailRef {
  _GetServiceDetailProviderElement(super.provider);

  @override
  String get id => (origin as GetServiceDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
