// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceListHash() => r'e25a1661c7f7cbc6cc86ab8c5eaade7458dc9022';

/// See also [ServiceList].
@ProviderFor(ServiceList)
final serviceListProvider =
    AsyncNotifierProvider<ServiceList, List<Service>>.internal(
  ServiceList.new,
  name: r'serviceListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$serviceListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ServiceList = AsyncNotifier<List<Service>>;
String _$serviceBasedStoresHash() =>
    r'b6a46bfba88c0821cdbf84d6e50029baaf582fd8';

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

abstract class _$ServiceBasedStores
    extends BuildlessAutoDisposeAsyncNotifier<List<StoreModel>> {
  late final int serviceID;

  FutureOr<List<StoreModel>> build(
    int serviceID,
  );
}

/// See also [ServiceBasedStores].
@ProviderFor(ServiceBasedStores)
const serviceBasedStoresProvider = ServiceBasedStoresFamily();

/// See also [ServiceBasedStores].
class ServiceBasedStoresFamily extends Family<AsyncValue<List<StoreModel>>> {
  /// See also [ServiceBasedStores].
  const ServiceBasedStoresFamily();

  /// See also [ServiceBasedStores].
  ServiceBasedStoresProvider call(
    int serviceID,
  ) {
    return ServiceBasedStoresProvider(
      serviceID,
    );
  }

  @override
  ServiceBasedStoresProvider getProviderOverride(
    covariant ServiceBasedStoresProvider provider,
  ) {
    return call(
      provider.serviceID,
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
  String? get name => r'serviceBasedStoresProvider';
}

/// See also [ServiceBasedStores].
class ServiceBasedStoresProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ServiceBasedStores, List<StoreModel>> {
  /// See also [ServiceBasedStores].
  ServiceBasedStoresProvider(
    int serviceID,
  ) : this._internal(
          () => ServiceBasedStores()..serviceID = serviceID,
          from: serviceBasedStoresProvider,
          name: r'serviceBasedStoresProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serviceBasedStoresHash,
          dependencies: ServiceBasedStoresFamily._dependencies,
          allTransitiveDependencies:
              ServiceBasedStoresFamily._allTransitiveDependencies,
          serviceID: serviceID,
        );

  ServiceBasedStoresProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceID,
  }) : super.internal();

  final int serviceID;

  @override
  FutureOr<List<StoreModel>> runNotifierBuild(
    covariant ServiceBasedStores notifier,
  ) {
    return notifier.build(
      serviceID,
    );
  }

  @override
  Override overrideWith(ServiceBasedStores Function() create) {
    return ProviderOverride(
      origin: this,
      override: ServiceBasedStoresProvider._internal(
        () => create()..serviceID = serviceID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceID: serviceID,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ServiceBasedStores, List<StoreModel>>
      createElement() {
    return _ServiceBasedStoresProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceBasedStoresProvider && other.serviceID == serviceID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ServiceBasedStoresRef
    on AutoDisposeAsyncNotifierProviderRef<List<StoreModel>> {
  /// The parameter `serviceID` of this provider.
  int get serviceID;
}

class _ServiceBasedStoresProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ServiceBasedStores,
        List<StoreModel>> with ServiceBasedStoresRef {
  _ServiceBasedStoresProviderElement(super.provider);

  @override
  int get serviceID => (origin as ServiceBasedStoresProvider).serviceID;
}

String _$nearByStoreServiceHash() =>
    r'77cda06a03e4d4d08ef477d1bc305fa023aad3d1';

abstract class _$NearByStoreService
    extends BuildlessAutoDisposeAsyncNotifier<List<Service>> {
  late final int storeId;

  FutureOr<List<Service>> build({
    required int storeId,
  });
}

/// See also [NearByStoreService].
@ProviderFor(NearByStoreService)
const nearByStoreServiceProvider = NearByStoreServiceFamily();

/// See also [NearByStoreService].
class NearByStoreServiceFamily extends Family<AsyncValue<List<Service>>> {
  /// See also [NearByStoreService].
  const NearByStoreServiceFamily();

  /// See also [NearByStoreService].
  NearByStoreServiceProvider call({
    required int storeId,
  }) {
    return NearByStoreServiceProvider(
      storeId: storeId,
    );
  }

  @override
  NearByStoreServiceProvider getProviderOverride(
    covariant NearByStoreServiceProvider provider,
  ) {
    return call(
      storeId: provider.storeId,
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
  String? get name => r'nearByStoreServiceProvider';
}

/// See also [NearByStoreService].
class NearByStoreServiceProvider extends AutoDisposeAsyncNotifierProviderImpl<
    NearByStoreService, List<Service>> {
  /// See also [NearByStoreService].
  NearByStoreServiceProvider({
    required int storeId,
  }) : this._internal(
          () => NearByStoreService()..storeId = storeId,
          from: nearByStoreServiceProvider,
          name: r'nearByStoreServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nearByStoreServiceHash,
          dependencies: NearByStoreServiceFamily._dependencies,
          allTransitiveDependencies:
              NearByStoreServiceFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  NearByStoreServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storeId,
  }) : super.internal();

  final int storeId;

  @override
  FutureOr<List<Service>> runNotifierBuild(
    covariant NearByStoreService notifier,
  ) {
    return notifier.build(
      storeId: storeId,
    );
  }

  @override
  Override overrideWith(NearByStoreService Function() create) {
    return ProviderOverride(
      origin: this,
      override: NearByStoreServiceProvider._internal(
        () => create()..storeId = storeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storeId: storeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NearByStoreService, List<Service>>
      createElement() {
    return _NearByStoreServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearByStoreServiceProvider && other.storeId == storeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NearByStoreServiceRef
    on AutoDisposeAsyncNotifierProviderRef<List<Service>> {
  /// The parameter `storeId` of this provider.
  int get storeId;
}

class _NearByStoreServiceProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NearByStoreService,
        List<Service>> with NearByStoreServiceRef {
  _NearByStoreServiceProviderElement(super.provider);

  @override
  int get storeId => (origin as NearByStoreServiceProvider).storeId;
}

String _$nearByStoresHash() => r'2c1c2160fbb3afda0f328285c1b8059feb47b41e';

/// See also [NearByStores].
@ProviderFor(NearByStores)
final nearByStoresProvider =
    AutoDisposeAsyncNotifierProvider<NearByStores, List<StoreModel>>.internal(
  NearByStores.new,
  name: r'nearByStoresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$nearByStoresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NearByStores = AutoDisposeAsyncNotifier<List<StoreModel>>;
String _$variantListHash() => r'419761b44c618818e46b227f43f0537321a6d0d8';

abstract class _$VariantList
    extends BuildlessAutoDisposeAsyncNotifier<List<VariantModel>> {
  late final ServiceArg arg;

  FutureOr<List<VariantModel>> build(
    ServiceArg arg,
  );
}

/// See also [VariantList].
@ProviderFor(VariantList)
const variantListProvider = VariantListFamily();

/// See also [VariantList].
class VariantListFamily extends Family<AsyncValue<List<VariantModel>>> {
  /// See also [VariantList].
  const VariantListFamily();

  /// See also [VariantList].
  VariantListProvider call(
    ServiceArg arg,
  ) {
    return VariantListProvider(
      arg,
    );
  }

  @override
  VariantListProvider getProviderOverride(
    covariant VariantListProvider provider,
  ) {
    return call(
      provider.arg,
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
  String? get name => r'variantListProvider';
}

/// See also [VariantList].
class VariantListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    VariantList, List<VariantModel>> {
  /// See also [VariantList].
  VariantListProvider(
    ServiceArg arg,
  ) : this._internal(
          () => VariantList()..arg = arg,
          from: variantListProvider,
          name: r'variantListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$variantListHash,
          dependencies: VariantListFamily._dependencies,
          allTransitiveDependencies:
              VariantListFamily._allTransitiveDependencies,
          arg: arg,
        );

  VariantListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final ServiceArg arg;

  @override
  FutureOr<List<VariantModel>> runNotifierBuild(
    covariant VariantList notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(VariantList Function() create) {
    return ProviderOverride(
      origin: this,
      override: VariantListProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<VariantList, List<VariantModel>>
      createElement() {
    return _VariantListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VariantListProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin VariantListRef
    on AutoDisposeAsyncNotifierProviderRef<List<VariantModel>> {
  /// The parameter `arg` of this provider.
  ServiceArg get arg;
}

class _VariantListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<VariantList,
        List<VariantModel>> with VariantListRef {
  _VariantListProviderElement(super.provider);

  @override
  ServiceArg get arg => (origin as VariantListProvider).arg;
}

String _$productListHash() => r'e9d7d0a512c19dab64cde4e7e125d623546fb5b9';

abstract class _$ProductList
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductModel>> {
  late final int serviceID;
  late final int variantID;

  FutureOr<List<ProductModel>> build({
    required int serviceID,
    required int variantID,
  });
}

/// See also [ProductList].
@ProviderFor(ProductList)
const productListProvider = ProductListFamily();

/// See also [ProductList].
class ProductListFamily extends Family<AsyncValue<List<ProductModel>>> {
  /// See also [ProductList].
  const ProductListFamily();

  /// See also [ProductList].
  ProductListProvider call({
    required int serviceID,
    required int variantID,
  }) {
    return ProductListProvider(
      serviceID: serviceID,
      variantID: variantID,
    );
  }

  @override
  ProductListProvider getProviderOverride(
    covariant ProductListProvider provider,
  ) {
    return call(
      serviceID: provider.serviceID,
      variantID: provider.variantID,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies =
      const <ProviderOrFamily>[];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      const <ProviderOrFamily>{};

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productListProvider';
}

/// See also [ProductList].
class ProductListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProductList, List<ProductModel>> {
  /// See also [ProductList].
  ProductListProvider({
    required int serviceID,
    required int variantID,
  }) : this._internal(
          () => ProductList()
            ..serviceID = serviceID
            ..variantID = variantID,
          from: productListProvider,
          name: r'productListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productListHash,
          dependencies: ProductListFamily._dependencies,
          allTransitiveDependencies:
              ProductListFamily._allTransitiveDependencies,
          serviceID: serviceID,
          variantID: variantID,
        );

  ProductListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceID,
    required this.variantID,
  }) : super.internal();

  final int serviceID;
  final int variantID;

  @override
  FutureOr<List<ProductModel>> runNotifierBuild(
    covariant ProductList notifier,
  ) {
    return notifier.build(
      serviceID: serviceID,
      variantID: variantID,
    );
  }

  @override
  Override overrideWith(ProductList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductListProvider._internal(
        () => create()
          ..serviceID = serviceID
          ..variantID = variantID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceID: serviceID,
        variantID: variantID,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductList, List<ProductModel>>
      createElement() {
    return _ProductListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductListProvider &&
        other.serviceID == serviceID &&
        other.variantID == variantID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceID.hashCode);
    hash = _SystemHash.combine(hash, variantID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductListRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductModel>> {
  /// The parameter `serviceID` of this provider.
  int get serviceID;

  /// The parameter `variantID` of this provider.
  int get variantID;
}

class _ProductListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductList,
        List<ProductModel>> with ProductListRef {
  _ProductListProviderElement(super.provider);

  @override
  int get serviceID => (origin as ProductListProvider).serviceID;
  @override
  int get variantID => (origin as ProductListProvider).variantID;
}

String _$allPromotionHash() => r'8b60b21d4d473fadd1bf78b78be3c3c75a4f0058';

/// See also [AllPromotion].
@ProviderFor(AllPromotion)
final allPromotionProvider =
    AsyncNotifierProvider<AllPromotion, PromotionsModel?>.internal(
  AllPromotion.new,
  name: r'allPromotionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPromotionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AllPromotion = AsyncNotifier<PromotionsModel?>;
String _$reviewControllerHash() => r'604b50919c0895d585cd50f91651aa2a4049ed67';

abstract class _$ReviewController
    extends BuildlessAutoDisposeAsyncNotifier<AllRatinngsModel?> {
  late final int storeId;

  FutureOr<AllRatinngsModel?> build({
    required int storeId,
  });
}

/// See also [ReviewController].
@ProviderFor(ReviewController)
const reviewControllerProvider = ReviewControllerFamily();

/// See also [ReviewController].
class ReviewControllerFamily extends Family<AsyncValue<AllRatinngsModel?>> {
  /// See also [ReviewController].
  const ReviewControllerFamily();

  /// See also [ReviewController].
  ReviewControllerProvider call({
    required int storeId,
  }) {
    return ReviewControllerProvider(
      storeId: storeId,
    );
  }

  @override
  ReviewControllerProvider getProviderOverride(
    covariant ReviewControllerProvider provider,
  ) {
    return call(
      storeId: provider.storeId,
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
  String? get name => r'reviewControllerProvider';
}

/// See also [ReviewController].
class ReviewControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ReviewController, AllRatinngsModel?> {
  /// See also [ReviewController].
  ReviewControllerProvider({
    required int storeId,
  }) : this._internal(
          () => ReviewController()..storeId = storeId,
          from: reviewControllerProvider,
          name: r'reviewControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reviewControllerHash,
          dependencies: ReviewControllerFamily._dependencies,
          allTransitiveDependencies:
              ReviewControllerFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  ReviewControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storeId,
  }) : super.internal();

  final int storeId;

  @override
  FutureOr<AllRatinngsModel?> runNotifierBuild(
    covariant ReviewController notifier,
  ) {
    return notifier.build(
      storeId: storeId,
    );
  }

  @override
  Override overrideWith(ReviewController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReviewControllerProvider._internal(
        () => create()..storeId = storeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storeId: storeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ReviewController, AllRatinngsModel?>
      createElement() {
    return _ReviewControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewControllerProvider && other.storeId == storeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReviewControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AllRatinngsModel?> {
  /// The parameter `storeId` of this provider.
  int get storeId;
}

class _ReviewControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReviewController,
        AllRatinngsModel?> with ReviewControllerRef {
  _ReviewControllerProviderElement(super.provider);

  @override
  int get storeId => (origin as ReviewControllerProvider).storeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
