import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/controllers/others_controller/order_condition_states.dart';
import 'package:parcel_track/models/about_us_model/about_us_model.dart';
import 'package:parcel_track/models/order_options_model/order_options_model.dart';
import 'package:parcel_track/models/store_model/address.dart';
import 'package:parcel_track/models/terms_and_condition_model/terms_and_condition_model.dart';
import 'package:parcel_track/services/other_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'others_controller.g.dart';

@Riverpod(keepAlive: true)
class OrderCondition extends _$OrderCondition {
  @override
  OrderConditionState build() {
    return OrderConditionState();
  }

  Future<void> getOrderConditions({required int storeId}) async {
    final response = await ref
        .read(otherServiceProvider)
        .getOrderConditions(storeId: storeId);

    if (response.statusCode == 200) {
      final orderOption = OrderOptionsModel.fromMap(response.data);
      state = OrderConditionState(
        deliveryCharge:
            double.tryParse(orderOption.data?.deliveryCharge ?? "0") ?? 0,
        minOrderAmount:
            double.tryParse(orderOption.data?.minOrderAmount ?? "0") ?? 0,
        maxOrderAmount:
            double.tryParse(orderOption.data?.maxOrderAmount ?? "0") ?? 0,
      );
    }
  }
}

@Riverpod(keepAlive: true)
class AddressList extends _$AddressList {
  @override
  FutureOr<List<Address>> build() {
    return ref.read(otherServiceProvider).getAddress().then((value) {
      if (value.statusCode == 200) {
        List<dynamic> list = value.data["data"]['addresses'] ?? [];
        List<Address> addressList =
            list.map((e) => Address.fromMap(e)).toList();
        // HINT: set default address
        if (addressList.isNotEmpty) {
          final defaultAddress = addressList.firstWhere(
            (element) => element.isDefault == 1,
            orElse: () => addressList.first,
          );
          ref.read(addressIdProvider.notifier).state = defaultAddress.id ?? 0;
        }
        return addressList;
      }
      return [];
    });
  }
}

@riverpod
class AddAddress extends _$AddAddress {
  @override
  bool build() {
    return false;
  }

  Future<bool> addAddress({required Map<String, dynamic> data}) async {
    state = true;
    final response =
        await ref.read(otherServiceProvider).addAddress(data: data);
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class UpdateAddress extends _$UpdateAddress {
  @override
  bool build() {
    return false;
  }

  Future<bool> updateAddress(
      {required int id, required Map<String, dynamic> data}) async {
    state = true;
    final response =
        await ref.read(otherServiceProvider).updateAddress(id: id, data: data);
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class TermsAndCondition extends _$TermsAndCondition {
  @override
  FutureOr<TermsAndConditionModel> build() async {
    return await ref
        .read(otherServiceProvider)
        .getTermsAndConditions()
        .then((value) => TermsAndConditionModel.fromMap(value.data));
  }
}

@riverpod
class PrivacyAndPolicy extends _$PrivacyAndPolicy {
  @override
  FutureOr<TermsAndConditionModel> build() {
    return ref
        .read(otherServiceProvider)
        .getPrivacyPolicy()
        .then((value) => TermsAndConditionModel.fromMap(value.data));
  }
}

@riverpod
class AboutUs extends _$AboutUs {
  @override
  FutureOr<AboutUsModel> build() {
    return ref
        .read(otherServiceProvider)
        .getAboutUs()
        .then((value) => AboutUsModel.fromMap(value.data));
  }
}

@riverpod
class DeleteAddress extends _$DeleteAddress {
  @override
  bool build() {
    return false;
  }

  Future<bool> deleteAddress({required int id}) async {
    state = true;
    final response = await ref.read(otherServiceProvider).deleteAddress(id: id);
    if (response.statusCode == 200) {
      ref.invalidate(addressListProvider);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}
