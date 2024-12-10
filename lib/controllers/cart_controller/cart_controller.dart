import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundrymart_flutter/models/cart_models/hive_cart_model.dart';

final cartController = ChangeNotifierProvider<CartController>((ref) {
  return CartController(ref: ref);
});

class CartController extends ChangeNotifier {
  CartController({required this.ref});
  Ref ref;
  double _subTotalAmount = 0;
  double _totalAmount = 0;
  double _payableAmount = 0;
  double _deliveryCharge = 0;
  double? _cuponDiscount;
  double get subTotalAmount => _subTotalAmount;
  double get cuponDiscountedAmount => _cuponDiscount ?? 0;
  double get deliveryCharge => _deliveryCharge;
  double get totalAmount => _totalAmount;
  double get payableAmount => _payableAmount;

  //getters
  void calculateSubTotal(List<HiveCartModel> cartItems) async {
    _subTotalAmount = 0;
    for (var item in cartItems) {
      _subTotalAmount += item.price * item.productsQTY;
    }
    _totalAmount = _subTotalAmount;
    cuponDiscount(discount: _cuponDiscount);
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void setCuponDiscount(double? discount) async {
    _cuponDiscount = discount;
    cuponDiscount(discount: _cuponDiscount);
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void cuponDiscount({double? discount}) async {
    if (discount == null) {
      return;
    }
    _totalAmount = _subTotalAmount - discount;
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void setDeliveryCharge({double? charge}) async {
    if (charge == null) {
      return;
    }
    _deliveryCharge = charge;
    _payableAmount = _totalAmount + _deliveryCharge;
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void clearFiles() {
    _subTotalAmount = 0;
    _cuponDiscount = 0;
    _deliveryCharge = 0;
    _totalAmount = 0;
    _payableAmount = 0;
    notifyListeners();
  }
}
