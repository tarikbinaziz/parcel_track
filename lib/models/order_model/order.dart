import 'dart:convert';

import 'address.dart';
import 'product.dart';
import 'shop.dart';

class Order {
  int? id;
  String? orderCode;
  dynamic driverStatus;
  bool? drivers;
  double? discount;
  double? payableAmount;
  double? totalAmount;
  double? deliveryCharge;
  String? orderStatus;
  String? paymentStatus;
  String? paymentType;
  String? pickDate;
  String? pickHour;
  String? deliveryDate;
  String? deliveryHour;
  String? orderedAt;
  dynamic rating;
  int? item;
  Address? address;
  List<Product>? products;
  Shop? shop;
  String? invoicePath;
  dynamic instruction;
  dynamic rider;

  Order({
    this.id,
    this.orderCode,
    this.driverStatus,
    this.drivers,
    this.discount,
    this.payableAmount,
    this.totalAmount,
    this.deliveryCharge,
    this.orderStatus,
    this.paymentStatus,
    this.paymentType,
    this.pickDate,
    this.pickHour,
    this.deliveryDate,
    this.deliveryHour,
    this.orderedAt,
    this.rating,
    this.item,
    this.address,
    this.products,
    this.shop,
    this.invoicePath,
    this.instruction,
    this.rider,
  });

  factory Order.fromMap(Map<String, dynamic> data) => Order(
        id: data['id'] as int?,
        orderCode: data['order_code'] as String?,
        driverStatus: data['driver_status'] as dynamic,
        drivers: data['drivers'] as bool?,
        discount: (data['discount'] as num?)?.toDouble(),
        payableAmount: (data['payable_amount'] as num?)?.toDouble(),
        totalAmount: (data['total_amount'] as num?)?.toDouble(),
        deliveryCharge: data['delivery_charge'] as double?,
        orderStatus: data['order_status'] as String?,
        paymentStatus: data['payment_status'] as String?,
        paymentType: data['payment_type'] as String?,
        pickDate: data['pick_date'] as String?,
        pickHour: data['pick_hour'] as String?,
        deliveryDate: data['delivery_date'] as String?,
        deliveryHour: data['delivery_hour'] as String?,
        orderedAt: data['ordered_at'] as String?,
        rating: data['rating'] as dynamic,
        item: data['item'] as int?,
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
        products: (data['products'] as List<dynamic>?)
            ?.map((e) => Product.fromMap(e as Map<String, dynamic>))
            .toList(),
        shop: data['shop'] == null
            ? null
            : Shop.fromMap(data['shop'] as Map<String, dynamic>),
        invoicePath: data['invoice_path'] as String?,
        instruction: data['instruction'] as dynamic,
        rider: data['rider'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_code': orderCode,
        'driver_status': driverStatus,
        'drivers': drivers,
        'discount': discount,
        'payable_amount': payableAmount,
        'total_amount': totalAmount,
        'delivery_charge': deliveryCharge,
        'order_status': orderStatus,
        'payment_status': paymentStatus,
        'payment_type': paymentType,
        'pick_date': pickDate,
        'pick_hour': pickHour,
        'delivery_date': deliveryDate,
        'delivery_hour': deliveryHour,
        'ordered_at': orderedAt,
        'rating': rating,
        'item': item,
        'address': address?.toMap(),
        'products': products?.map((e) => e.toMap()).toList(),
        'shop': shop?.toMap(),
        'invoice_path': invoicePath,
        'instruction': instruction,
        'rider': rider,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());
}
