import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_service.g.dart';

@riverpod
ProfileService profileService(ProfileServiceRef ref) {
  return ProfileService(ref);
}

abstract class ProfileRepo {
  Future<Response> updateProfile({required Map<String, dynamic> data});
}

class ProfileService implements ProfileRepo {
  final Ref ref;
  ProfileService(this.ref);

  @override
  Future<Response> updateProfile({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.updateProfile, data: FormData.fromMap(data));
  }
}
