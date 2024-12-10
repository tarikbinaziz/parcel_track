import 'dart:convert';

import 'service.dart';
import 'variant.dart';

class ProductModel {
  int? id;
  String? name;
  dynamic nameBn;
  dynamic slug;
  double? currentPrice;
  double? oldPrice;
  dynamic description;
  String? imagePath;
  double? discountPercentage;
  dynamic qrcodeUrl;
  Service? service;
  Variant? variant;

  ProductModel({
    this.id,
    this.name,
    this.nameBn,
    this.slug,
    this.currentPrice,
    this.oldPrice,
    this.description,
    this.imagePath,
    this.discountPercentage,
    this.qrcodeUrl,
    this.service,
    this.variant,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        nameBn: data['name_bn'] as dynamic,
        slug: data['slug'] as dynamic,
        currentPrice: data['current_price'] as double?,
        oldPrice: data['old_price'] as double?,
        description: data['description'] as dynamic,
        imagePath: data['image_path'] as String?,
        discountPercentage: data['discount_percentage'] as double?,
        qrcodeUrl: data['qrcode_url'] as dynamic,
        service: data['service'] == null
            ? null
            : Service.fromMap(data['service'] as Map<String, dynamic>),
        variant: data['variant'] == null
            ? null
            : Variant.fromMap(data['variant'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'name_bn': nameBn,
        'slug': slug,
        'current_price': currentPrice,
        'old_price': oldPrice,
        'description': description,
        'image_path': imagePath,
        'discount_percentage': discountPercentage,
        'qrcode_url': qrcodeUrl,
        'service': service?.toMap(),
        'variant': variant?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
