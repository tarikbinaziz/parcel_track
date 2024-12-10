import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCartModel {
  int id;
  String name;
  String thumbnail;
  double price;
  int productsQTY;
  double discountPercentage;
  double oldPrice;

  HiveCartModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.productsQTY,
    required this.discountPercentage,
    required this.oldPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'price': price,
      'productsQTY': productsQTY,
      'discountPercentage': discountPercentage,
      'oldPrice': oldPrice,
    };
  }

  factory HiveCartModel.fromMap(Map<dynamic, dynamic> map) {
    return HiveCartModel(
      id: map['id'] as int,
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
      price: map['price'] as double,
      productsQTY: map['productsQTY'] as int,
      discountPercentage: map['discountPercentage'] as double,
      oldPrice: map['oldPrice'] as double,
    );
  }

  HiveCartModel copyWith({
    int? id,
    String? name,
    String? thumbnail,
    double? price,
    int? productsQTY,
    double? discountPercentage,
    double? oldPrice,
  }) {
    return HiveCartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      productsQTY: productsQTY ?? this.productsQTY,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      oldPrice: oldPrice ?? this.oldPrice,
    );
  }

  String toJson() => json.encode(toMap());

  factory HiveCartModel.fromJson(String source) =>
      HiveCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HiveCartModelAdapter extends TypeAdapter<HiveCartModel> {
  @override
  final typeId = 0;

  @override
  HiveCartModel read(BinaryReader reader) {
    return HiveCartModel.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, HiveCartModel obj) {
    writer.writeMap(obj.toMap());
  }
}
