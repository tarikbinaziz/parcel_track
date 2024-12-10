import 'dart:convert';

class VariantModel {
  int? id;
  String? name;
  dynamic nameBn;

  VariantModel({this.id, this.name, this.nameBn});

  factory VariantModel.fromMap(Map<String, dynamic> data) => VariantModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        nameBn: data['name_bn'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'name_bn': nameBn,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VariantModel].
  factory VariantModel.fromJson(String data) {
    return VariantModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VariantModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
