import 'package:parcel_track/controllers/cart_controller/cart_controller.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/models/order_model/order_model.dart';
import 'package:parcel_track/services/order_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parcel_track/models/order_model/order.dart';
part 'orders_controller.g.dart';

@riverpod
class AddOrder extends _$AddOrder {
  @override
  bool build() {
    return false;
  }

  Future<OrderModel?> addOrder({required Map<String, dynamic> data}) async {
    state = true;
    final response = await ref.read(orderServiceProvider).addOrder(data: data);
    if (response.statusCode == 200) {
      state = false;
      return OrderModel.fromMap(response.data);
    } else {
      state = false;
      return null;
    }
  }
}

@riverpod
class OrderList extends _$OrderList {
  List<Order> _orders = [];

  @override
  FutureOr<List<Order>> build() async {
    final value = await ref.read(orderServiceProvider).getOrders();
    if (value.statusCode == 200) {
      _orders = (value.data['data']['orders'] as List<dynamic>)
          .map((e) => Order.fromMap(e))
          .toList();
      return _orders;
    }
    return [];
  }

  void filterData({required List<String> status}) async {
    if (status.isEmpty) {
      return resetData();
    }
    state = const AsyncLoading();

    final filteredOrders = _orders.where((order) {
      return status.contains(order.orderStatus?.toLowerCase());
    }).toList();

    state = AsyncData(filteredOrders);
  }

  void resetData() {
    state = const AsyncLoading();
    state = AsyncData(_orders);
  }
}

@riverpod
class CancelOrder extends _$CancelOrder {
  @override
  bool build() {
    return false;
  }

  Future<bool> cancelOrder({required int orderId}) async {
    state = true;
    final response =
        await ref.read(orderServiceProvider).cancelOrder(orderId: orderId);
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class ApplyCoupon extends _$ApplyCoupon {
  @override
  bool build() {
    return false;
  }

  Future<bool> applyCoupon({
    required String couponCode,
    required double amount,
    required int storeId,
  }) async {
    state = true;
    final response = await ref
        .read(orderServiceProvider)
        .applyCoupon(couponCode: couponCode, storeId: storeId, amount: amount);
    if (response.statusCode == 200) {
      double discount = response.data['data']['coupon']['discount'] as double;
      ref.read(couponIdProvider.notifier).state =
          response.data['data']['coupon']['id'] as int;
      ref.read(cartController).setCuponDiscount(discount);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class ReOrder extends _$ReOrder {
  @override
  bool build() {
    return false;
  }

  Future<OrderModel?> reOrder({required Map<String, dynamic> data}) async {
    state = true;
    final response = await ref.read(orderServiceProvider).reOrder(data: data);
    if (response.statusCode == 200) {
      state = false;
      return OrderModel.fromMap(response.data);
    } else {
      state = false;
      return null;
    }
  }
}
