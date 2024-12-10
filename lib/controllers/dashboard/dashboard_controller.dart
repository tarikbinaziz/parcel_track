import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/models/all_ratinngs_model/all_ratinngs_model.dart';
import 'package:parcel_track/models/others.dart';
import 'package:parcel_track/models/product_model/product_model.dart';
import 'package:parcel_track/models/promotions_model/promotions_model.dart';
import 'package:parcel_track/models/service_model.dart';
import 'package:parcel_track/models/store_model/store_model.dart';
import 'package:parcel_track/models/variant_model.dart';
import 'package:parcel_track/services/dashboard_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller.g.dart';

@Riverpod(keepAlive: true)
class ServiceList extends _$ServiceList {
  @override
  FutureOr<List<Service>> build() async {
    return await ref
        .read(dashboardServiceProvider)
        .getServices()
        .then((response) {
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data']["services"];
        List<Service> serviceList =
            list.map<Service>((e) => Service.fromMap(e)).toList();
        return serviceList;
      } else {
        return [];
      }
    });
  }
}

@riverpod
class ServiceBasedStores extends _$ServiceBasedStores {
  @override
  FutureOr<List<StoreModel>> build(int serviceID) async {
    Box locationBox = Hive.box(AppConstants.locationBox);
    return await ref.read(dashboardServiceProvider).getStores(query: {
      "service_id": serviceID,
      "latitude": locationBox.get("latitude"),
      "longitude": locationBox.get("longitude"),
    }).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data']["stores"];
        List<StoreModel> storeList =
            list.map<StoreModel>((e) => StoreModel.fromMap(e)).toList();
        return storeList;
      } else {
        return [];
      }
    });
  }
}

@riverpod
class NearByStoreService extends _$NearByStoreService {
  @override
  FutureOr<List<Service>> build({required int storeId}) async {
    return await ref
        .read(dashboardServiceProvider)
        .nearByStoreService(storeId: storeId)
        .then((response) {
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data']["services"];
        List<Service> serviceList =
            list.map<Service>((e) => Service.fromMap(e)).toList();
        return serviceList;
      } else {
        return [];
      }
    });
  }
}

@riverpod
class NearByStores extends _$NearByStores {
  @override
  FutureOr<List<StoreModel>> build() async {
    Box locationBox = Hive.box(AppConstants.locationBox);
    return await ref.read(dashboardServiceProvider).getNearByStores(data: {
      "latitude": locationBox.get("latitude"),
      "longitude": locationBox.get("longitude"),
    }).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data']["stores"];
        List<StoreModel> storeList =
            list.map<StoreModel>((e) => StoreModel.fromMap(e)).toList();
        return storeList;
      } else {
        return [];
      }
    });
  }
}

@riverpod
class VariantList extends _$VariantList {
  @override
  FutureOr<List<VariantModel>> build(ServiceArg arg) async {
    return await ref.read(dashboardServiceProvider).getVariants(data: {
      "service_id": arg.serviceID,
      "store_id": arg.storeID,
    }).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data']["variants"] ?? [];
        if (list.isEmpty) return [];
        List<VariantModel> variantList =
            list.map<VariantModel>((e) => VariantModel.fromMap(e)).toList();
        // ignore: avoid_manual_providers_as_generated_provider_dependency
        ref.watch(selectedVarientIDProvider.notifier).state =
            variantList.first.id;
        return variantList;
      } else {
        return [];
      }
    });
  }
}

@Riverpod(dependencies: [])
class ProductList extends _$ProductList {
  @override
  FutureOr<List<ProductModel>> build(
      {required int serviceID, required int variantID}) async {
    return await ref.read(dashboardServiceProvider).getProducts(data: {
      "service_id": serviceID,
      "variant_id": variantID,
    }).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data']["products"];
        List<ProductModel> productList =
            list.map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
        return productList;
      } else {
        return [];
      }
    });
  }
}

@Riverpod(keepAlive: true)
class AllPromotion extends _$AllPromotion {
  @override
  FutureOr<PromotionsModel?> build() async {
    return await ref
        .read(dashboardServiceProvider)
        .getPromotions()
        .then((response) {
      if (response.statusCode == 200) {
        return PromotionsModel.fromMap(response.data);
      } else {
        return null;
      }
    });
  }
}

@riverpod
class ReviewController extends _$ReviewController {
  @override
  FutureOr<AllRatinngsModel?> build({required int storeId}) async {
    return ref
        .read(dashboardServiceProvider)
        .getRating(storeId: storeId)
        .then((response) {
      if (response.statusCode == 200) {
        return AllRatinngsModel.fromMap(response.data);
      } else {
        return null;
      }
    });
  }
}
