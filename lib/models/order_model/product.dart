import 'dart:convert';

class Product {
  int? id;
  String? name;
  dynamic nameBn;
  double? price;
  int? quantity;
  String? imagePath;
  String? serviceName;

  Product({
    this.id,
    this.name,
    this.nameBn,
    this.price,
    this.quantity,
    this.imagePath,
    this.serviceName,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: data['id'] as int?,
        name: data['name'] as String?,
        nameBn: data['name_bn'] as dynamic,
        price: (data['price'] as num?)?.toDouble(),
        quantity: data['quantity'] as int?,
        imagePath: data['image_path'] as String?,
        serviceName: data['service_name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'name_bn': nameBn,
        'price': price,
        'quantity': quantity,
        'image_path': imagePath,
        'service_name': serviceName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}
