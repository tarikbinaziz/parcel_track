import 'dart:convert';

class Shop {
  int? id;
  String? logo;
  String? name;
  String? phone;

  Shop({this.id, this.logo, this.name, this.phone});

  factory Shop.fromMap(Map<String, dynamic> data) => Shop(
        id: data['id'] as int?,
        logo: data['logo'] as String?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'logo': logo,
        'name': name,
        'phone': phone,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Shop].
  factory Shop.fromJson(String data) {
    return Shop.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Shop] to a JSON string.
  String toJson() => json.encode(toMap());
}
