import 'dart:convert';

import 'address.dart';
import 'owner.dart';

class StoreModel {
  int? id;
  String? name;
  Owner? owner;
  String? logo;
  String? bannerId;
  double? deliveryCharge;
  double? minOrderAmount;
  double? maxOrderAmount;
  String? prifix;
  String? description;
  double? commission;
  String? latitude;
  String? longitude;
  String? distance;
  int? totalRating;
  String? averageRating;
  Address? address;

  StoreModel({
    this.id,
    this.name,
    this.owner,
    this.logo,
    this.bannerId,
    this.deliveryCharge,
    this.minOrderAmount,
    this.maxOrderAmount,
    this.prifix,
    this.description,
    this.commission,
    this.latitude,
    this.longitude,
    this.distance,
    this.totalRating,
    this.averageRating,
    this.address,
  });

  factory StoreModel.fromMap(Map<String, dynamic> data) => StoreModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        owner: data['owner'] == null
            ? null
            : Owner.fromMap(data['owner'] as Map<String, dynamic>),
        logo: data['logo'] as String?,
        bannerId: data['banner_id'] as String?,
        deliveryCharge: (data['delivery_charge'] as num?)?.toDouble(),
        minOrderAmount: data['min_order_amount'] as double?,
        maxOrderAmount: data['max_order_amount'] as double?,
        prifix: data['prifix'] as String?,
        description: data['description'] as String?,
        commission: data['commission'] as double?,
        latitude: data['latitude'] as String?,
        longitude: data['longitude'] as String?,
        distance: data['distance'] as String?,
        totalRating: data['total_rating'] as int?,
        averageRating: data['average_rating'] as String?,
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'owner': owner?.toMap(),
        'logo': logo,
        'banner_id': bannerId,
        'delivery_charge': deliveryCharge,
        'min_order_amount': minOrderAmount,
        'max_order_amount': maxOrderAmount,
        'prifix': prifix,
        'description': description,
        'commission': commission,
        'latitude': latitude,
        'longitude': longitude,
        'distance': distance,
        'total_rating': totalRating,
        'average_rating': averageRating,
        'address': address?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StoreModel].
  factory StoreModel.fromJson(String data) {
    return StoreModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StoreModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
