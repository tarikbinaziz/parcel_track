import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcel_track/controllers/misc/enums.dart';
import 'package:parcel_track/models/app_settings.dart/app_settings.dart';

final homeScreenIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final journeyStepProvider = StateProvider<int>((ref) {
  return 0;
});

final selectedVarientIDProvider = AutoDisposeStateProvider<int?>(
  (ref) => null,
);

final pickupDateProvider = AutoDisposeStateProvider<DateTime?>((ref) {
  return null;
});

final deliveryDateProvider = AutoDisposeStateProvider<DateTime?>((ref) {
  return null;
});

final selectedPaymentTypeProvider = StateProvider<PaymentType>(
  (ref) => PaymentType.cod,
);

final selectedAddressTagProvider = StateProvider<AddressTag>(
  (ref) => AddressTag.home,
);

final selectedNotificationTypeProvider = StateProvider<NotificationType>(
  (ref) => NotificationType.all,
);

final showServiceItemProvider = StateProvider<bool>((ref) => true);

final pickProfileImgProvider = StateProvider<XFile?>((ref) => null);

// final storeIdProvider = StateProvider<int>((ref) {
//   return 0;
// });

final addressIdProvider = StateProvider<int?>((ref) {
  return null;
});

final onBoardingSliderIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final onBoardingSliderControllerProvider =
    Provider.family.autoDispose<PageController, String>((ref, name) {
  return PageController();
});

final orderIdProvider = StateProvider<int?>((ref) {
  return null;
});

final couponIdProvider = StateProvider<int?>((ref) {
  return null;
});

final selectedStatusesProvider = StateProvider<List<String>>((ref) => []);

final appSettingDataProvider = StateProvider<AppSettings>(
  (ref) => AppSettings(
    currency: '',
    iosUrl: '',
    androidUrl: '',
    twoStepVerification: false,
    deviceType: 'mobile',
    cashOnDelivery: true,
    onlinePayment: false,
  ),
);
