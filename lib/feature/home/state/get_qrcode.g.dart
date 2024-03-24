// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qrcode.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getQrCodeHash() => r'bac3549f1b361652580f58b10b19c9559f3bbda5';

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

/// See also [getQrCode].
@ProviderFor(getQrCode)
const getQrCodeProvider = GetQrCodeFamily();

/// See also [getQrCode].
class GetQrCodeFamily extends Family<AsyncValue<Uint8List>> {
  /// See also [getQrCode].
  const GetQrCodeFamily();

  /// See also [getQrCode].
  GetQrCodeProvider call(
    int amount,
  ) {
    return GetQrCodeProvider(
      amount,
    );
  }

  @override
  GetQrCodeProvider getProviderOverride(
    covariant GetQrCodeProvider provider,
  ) {
    return call(
      provider.amount,
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
  String? get name => r'getQrCodeProvider';
}

/// See also [getQrCode].
class GetQrCodeProvider extends AutoDisposeFutureProvider<Uint8List> {
  /// See also [getQrCode].
  GetQrCodeProvider(
    int amount,
  ) : this._internal(
          (ref) => getQrCode(
            ref as GetQrCodeRef,
            amount,
          ),
          from: getQrCodeProvider,
          name: r'getQrCodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getQrCodeHash,
          dependencies: GetQrCodeFamily._dependencies,
          allTransitiveDependencies: GetQrCodeFamily._allTransitiveDependencies,
          amount: amount,
        );

  GetQrCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.amount,
  }) : super.internal();

  final int amount;

  @override
  Override overrideWith(
    FutureOr<Uint8List> Function(GetQrCodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetQrCodeProvider._internal(
        (ref) => create(ref as GetQrCodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Uint8List> createElement() {
    return _GetQrCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetQrCodeProvider && other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetQrCodeRef on AutoDisposeFutureProviderRef<Uint8List> {
  /// The parameter `amount` of this provider.
  int get amount;
}

class _GetQrCodeProviderElement
    extends AutoDisposeFutureProviderElement<Uint8List> with GetQrCodeRef {
  _GetQrCodeProviderElement(super.provider);

  @override
  int get amount => (origin as GetQrCodeProvider).amount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
