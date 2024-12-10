import 'dart:convert';

import 'data.dart';

class TermsAndConditionModel {
  String? message;
  Data? data;

  TermsAndConditionModel({this.message, this.data});

  factory TermsAndConditionModel.fromMap(Map<String, dynamic> data) {
    return TermsAndConditionModel(
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TermsAndConditionModel].
  factory TermsAndConditionModel.fromJson(String data) {
    return TermsAndConditionModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TermsAndConditionModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
