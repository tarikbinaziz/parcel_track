import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_controller.g.dart';

@riverpod
class Login extends _$Login {
  @override
  bool build() {
    return false;
  }

  Future<bool> login({required String phone, required String password}) async {
    state = true;
    final formData = {
      'mobile': phone,
      'password': password,
      'type': "mobile",
      // 'device_key': token,
      'device_type': Platform.isAndroid ? 'android' : 'ios',
    };
    final response = await ref.read(authServiceProvider).login(data: formData);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.authToken, data['access']['token']);
      authBox.put(AppConstants.userData, data['user']);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class SignUp extends _$SignUp {
  @override
  bool build() {
    return false;
  }

  Future<bool> signUp({required Map<String, dynamic> data}) async {
    state = true;
    final formData = {...data, "type": "mobile"};
    final response = await ref.read(authServiceProvider).signUp(data: formData);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.authToken, data['access']['token']);
      authBox.put(AppConstants.userData, data['user']);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class Logout extends _$Logout {
  @override
  bool build() {
    return false;
  }

  Future<bool> logout() async {
    state = true;
    final response = await ref.read(authServiceProvider).logout();
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}
