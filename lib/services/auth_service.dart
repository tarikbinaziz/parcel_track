import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_service.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref);
}

abstract class AuthRepo {
  Future<Response> login({required Map<String, dynamic> data});
  Future<Response> signUp({required Map<String, dynamic> data});
  Future<Response> logout();
}

class AuthService implements AuthRepo {
  final Ref ref;
  AuthService(this.ref);

  @override
  Future<Response> login({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).post(AppConstants.loginUrl, data: data);
  }

  @override
  Future<Response> signUp({required Map<String, dynamic> data}) {
    return ref.read(apiClientProvider).post(AppConstants.signUp, data: data);
  }

  @override
  Future<Response> logout() {
    return ref.read(apiClientProvider).post(AppConstants.logout);
  }
}
