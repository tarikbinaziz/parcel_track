import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/models/app_settings.dart/app_settings.dart';
import 'package:laundrymart_flutter/services/other_service.dart';

final appSettingsProvider = NotifierProvider<AppSettingsProvider, int>(() {
  return AppSettingsProvider();
});

class AppSettingsProvider extends Notifier<int> {
  @override
  int build() {
    init();
    return 0;
  }

  Future<void> init() async {
    return await ref.read(otherServiceProvider).appSettings().then((value) {
      if (value.statusCode == 200) {
        debugPrint("master fetch");
        final appSettings = AppSettings.fromMap(value.data['data']);
        ref.read(appSettingDataProvider.notifier).state = appSettings;
      } else {
        debugPrint("master not fetch");
      }
    });
  }

  // String currencyValue(double value) {
  //   if (currencyPosition == 'Prefix') {
  //     return "$symbol${value.toStringAsFixed(2)}";
  //   } else {
  //     return "${value.toStringAsFixed(2)}$symbol";
  //   }
  // }
}
