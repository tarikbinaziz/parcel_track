import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'other_service.g.dart';

@riverpod
OtherService otherService(OtherServiceRef ref) {
  return OtherService(ref);
}

abstract class OtherRepo {
  Future<Response> getOrderConditions({required int storeId});
  Future<Response> getAddress();
  Future<Response> addAddress({required Map<String, dynamic> data});
  Future<Response> updateAddress(
      {required int id, required Map<String, dynamic> data});
  Future<Response> getTermsAndConditions();
  Future<Response> getPrivacyPolicy();
  Future<Response> getAboutUs();
  Future<Response> deleteAddress({required int id});
  Future<Response> appSettings();
}

class OtherService implements OtherRepo {
  final Ref ref;
  OtherService(this.ref);

  @override
  Future<Response> getOrderConditions({required int storeId}) {
    return ref
        .read(apiClientProvider)
        .get("${AppConstants.orderConditions}/$storeId");
  }

  @override
  Future<Response> getAddress() {
    return ref.read(apiClientProvider).get(AppConstants.address);
  }

  @override
  Future<Response> addAddress({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).post(AppConstants.address, data: data);
  }

  @override
  Future<Response> updateAddress(
      {required int id, required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post("${AppConstants.address}/$id", data: data);
  }

  @override
  Future<Response> getTermsAndConditions() {
    return ref.read(apiClientProvider).get(AppConstants.termsAndConditions);
  }

  @override
  Future<Response> getPrivacyPolicy() {
    return ref.read(apiClientProvider).get(AppConstants.privacyPolicy);
  }

  @override
  Future<Response> getAboutUs() {
    return ref.read(apiClientProvider).get(AppConstants.aboutUs);
  }

  @override
  Future<Response> deleteAddress({required int id}) {
    return ref
        .read(apiClientProvider)
        .delete("${AppConstants.address}/$id/delete");
  }

  @override
  Future<Response> appSettings() {
    final response = ref.read(apiClientProvider).get(AppConstants.master);
    return response;
  }
}
