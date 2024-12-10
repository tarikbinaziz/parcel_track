import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/views/dashboard/components/bottom_nav_bar.dart';
import 'package:parcel_track/views/dashboard/home_screen/home_screen.dart';
import 'package:parcel_track/views/dashboard/nearby_store/near_by_store.dart';
import 'package:parcel_track/views/dashboard/profile_screen/profile_screen.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});
  Widget _getChild(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const NearbyStoreScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(homeScreenIndexProvider);
    return Scaffold(
      extendBody: true,
      body: _getChild(selectedIndex),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
