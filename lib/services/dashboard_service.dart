import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dashboard_service.g.dart';

@riverpod
DashboardService dashboardService(DashboardServiceRef ref) =>
    DashboardService(ref);

abstract class DashboardServiceRepo {
  Future<Response> getPromotions();
  Future<Response> getServices();
  Future<Response> nearByStoreService({required int storeId});
  Future<Response> getStores({required Map<String, dynamic> query});
  Future<Response> getVariants({required Map<String, dynamic> data});
  Future<Response> getProducts({required Map<String, dynamic> data});
  Future<Response> getNearByStores({required Map<String, dynamic> data});
  Future<Response> getRating({required int storeId});
}

class DashboardService implements DashboardServiceRepo {
  final Ref ref;
  DashboardService(this.ref);

  @override
  Future<Response> getServices() {
    return ref.read(apiClientProvider).get(AppConstants.services);
  }

  @override
  Future<Response> nearByStoreService({required int storeId}) {
    return ref.read(apiClientProvider).get(AppConstants.services, query: {
      'store_id': storeId,
    });
  }

  @override
  Future<Response> getStores({required Map<String, dynamic> query}) {
    return ref.read(apiClientProvider).get(AppConstants.stores, query: query);
  }

  @override
  Future<Response> getVariants({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).get(AppConstants.variants, query: data);
  }

  @override
  Future<Response> getProducts({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).get(AppConstants.products, query: data);
  }

  @override
  Future<Response> getNearByStores({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).get(AppConstants.stores, query: data);
  }

  @override
  Future<Response> getPromotions() {
    return ref.read(apiClientProvider).get(AppConstants.promotions);
  }

  @override
  Future<Response> getRating({required int storeId}) {
    return ref.read(apiClientProvider).get("${AppConstants.ratings}/$storeId");
  }
}
