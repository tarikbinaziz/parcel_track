import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/services/profile_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_controller.g.dart';

@riverpod
class UpdateProfile extends _$UpdateProfile {
  @override
  bool build() {
    return false;
  }

  Future<bool> updateProfile({required Map<String, dynamic> data}) async {
    state = true;
    final response =
        await ref.read(profileServiceProvider).updateProfile(data: data);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.userData, data['user']);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}
