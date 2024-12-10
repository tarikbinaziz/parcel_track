import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/controllers/app_settings_provider.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/views/dashboard/home_screen/components/banner_section.dart';
import 'package:parcel_track/views/dashboard/home_screen/components/home_appBar.dart';
import 'package:parcel_track/views/dashboard/home_screen/components/service_section.dart';
import 'package:location/location.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationBox = Hive.box(AppConstants.locationBox);
      if (locationBox.isEmpty) {
        getLocation(Location());
      }
      ref.read(appSettingsProvider);
    });
  }

  Future<void> getLocation(Location location) async {
    debugPrint("getLocation call in home");
    final locationBox = Hive.box(AppConstants.locationBox);
    LocationData locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      debugPrint(
        "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}",
      );
      await locationBox.putAll({
        "latitude": locationData.latitude,
        "longitude": locationData.longitude,
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const HomeAppBar(),
          10.ph,
          const BannerSection(),
          10.ph,
          const ServiceSection()
        ],
      ),
    );
  }
}
