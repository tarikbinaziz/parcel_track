import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_service.g.dart';

@riverpod
OrderService orderService(OrderServiceRef ref) {
  return OrderService(ref);
}

abstract class OrderRepo {
  Future<Response> addOrder({required Map<String, dynamic> data});
  Future<Response> getOrders();
  Future<Response> cancelOrder({required int orderId});
  Future<Response> applyCoupon({
    required String couponCode,
    required int storeId,
    required double amount,
  });
  Future<Response> reOrder({required Map<String, dynamic> data});
}

class OrderService implements OrderRepo {
  final Ref ref;
  OrderService(this.ref);

  @override
  Future<Response> addOrder({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).post(AppConstants.order, data: data);
  }

  @override
  Future<Response> getOrders() {
    return ref.read(apiClientProvider).get(AppConstants.order);
  }

  @override
  Future<Response> cancelOrder({required int orderId}) {
    return ref
        .read(apiClientProvider)
        .post('${AppConstants.order}/$orderId/cancle');
  }

  @override
  Future<Response> applyCoupon(
      {required String couponCode,
      required int storeId,
      required double amount}) {
    return ref.read(apiClientProvider).post(
      "${AppConstants.applyCoupon}/$couponCode/apply",
      data: {
        'store_id': storeId,
        'amount': amount,
      },
    );
  }

  @override
  Future<Response> reOrder({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).post(AppConstants.reOrder, data: data);
  }
}
