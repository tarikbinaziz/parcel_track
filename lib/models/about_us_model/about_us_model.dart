import 'dart:convert';

import 'data.dart';

class AboutUsModel {
  String? message;
  Data? data;

  AboutUsModel({this.message, this.data});

  factory AboutUsModel.fromMap(Map<String, dynamic> data) => AboutUsModel(
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AboutUsModel].
  factory AboutUsModel.fromJson(String data) {
    return AboutUsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AboutUsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
