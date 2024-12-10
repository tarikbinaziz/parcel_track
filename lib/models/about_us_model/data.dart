import 'dart:convert';

class Data {
  dynamic title;
  dynamic phone;
  dynamic whatsapp;
  dynamic email;
  dynamic desceiption;

  Data({
    this.title,
    this.phone,
    this.whatsapp,
    this.email,
    this.desceiption,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        title: data['title'] as dynamic,
        phone: data['phone'] as dynamic,
        whatsapp: data['whatsapp'] as dynamic,
        email: data['email'] as dynamic,
        desceiption: data['desceiption'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'phone': phone,
        'whatsapp': whatsapp,
        'email': email,
        'desceiption': desceiption,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
