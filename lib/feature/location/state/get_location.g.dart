// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLocationHash() => r'438e1d7a841f7b4c1253796878a0cf4a8f3a65c0';

/// See also [getLocation].
@ProviderFor(getLocation)
final getLocationProvider =
    AutoDisposeFutureProvider<List<LocationModel>>.internal(
  getLocation,
  name: r'getLocationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLocationRef = AutoDisposeFutureProviderRef<List<LocationModel>>;
String _$getLocationDefaultHash() =>
    r'01f589de6ad1cba9b2c93ee5c6d35f400698b5b8';

/// See also [getLocationDefault].
@ProviderFor(getLocationDefault)
final getLocationDefaultProvider =
    AutoDisposeFutureProvider<LocationModel?>.internal(
  getLocationDefault,
  name: r'getLocationDefaultProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLocationDefaultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLocationDefaultRef = AutoDisposeFutureProviderRef<LocationModel?>;
String _$deleteLocationHash() => r'034db6e2ebf7501e6967a3ed363bd75c37818cbe';

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

/// See also [deleteLocation].
@ProviderFor(deleteLocation)
const deleteLocationProvider = DeleteLocationFamily();

/// See also [deleteLocation].
class DeleteLocationFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteLocation].
  const DeleteLocationFamily();

  /// See also [deleteLocation].
  DeleteLocationProvider call(
    int id,
  ) {
    return DeleteLocationProvider(
      id,
    );
  }

  @override
  DeleteLocationProvider getProviderOverride(
    covariant DeleteLocationProvider provider,
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
  String? get name => r'deleteLocationProvider';
}

/// See also [deleteLocation].
class DeleteLocationProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteLocation].
  DeleteLocationProvider(
    int id,
  ) : this._internal(
          (ref) => deleteLocation(
            ref as DeleteLocationRef,
            id,
          ),
          from: deleteLocationProvider,
          name: r'deleteLocationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteLocationHash,
          dependencies: DeleteLocationFamily._dependencies,
          allTransitiveDependencies:
              DeleteLocationFamily._allTransitiveDependencies,
          id: id,
        );

  DeleteLocationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteLocationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteLocationProvider._internal(
        (ref) => create(ref as DeleteLocationRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteLocationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteLocationProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteLocationRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  int get id;
}

class _DeleteLocationProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DeleteLocationRef {
  _DeleteLocationProviderElement(super.provider);

  @override
  int get id => (origin as DeleteLocationProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
