import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/controllers/app_settings_provider.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  Location location = Location();
  Box? locationBox;
  late ScrollController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool startCurveAnimation = false;
  Box appSettingsBox = Hive.box(AppConstants.appSettingsBox);

  @override
  void initState() {
    super.initState();
    debugPrint("call init");
    locationBox = Hive.box(AppConstants.locationBox);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appSettingsProvider);
    });

    _controller = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    scroll();

    // // Simple Navigation
    // _animationController.addStatusListener((status) async {
    //   if (status == AnimationStatus.completed) {
    //     await Future.delayed(const Duration(seconds: 2));
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    //   }
    // });
    // Add this widget as an observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> scroll() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Timer(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            startCurveAnimation = true;
          });
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: const Duration(minutes: 1),
            curve: Curves.linear,
          );
        }
      });

      // Delay permission request until the animation finishes
      await Future.delayed(const Duration(milliseconds: 500), () {
        debugPrint("request permission");

        requestLocationPermission();
      });
    });
  }

  // void initAppSettingData() {
  //   ref.read(appSettingsProvider.notifier).init().then((appSettings) {
  //     ref.read(appSettingDataProvider.notifier).state = appSettings;
  //     debugPrint("appsettings: ${ref.read(appSettingDataProvider)}");
  //   });
  // }

  void showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? action,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            if (action != null)
              TextButton(
                onPressed: action,
                child: const Text("Open Settings"),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> getLocation(Location location) async {
    try {
      LocationData locationData = await location.getLocation();

      if (locationData.latitude != null && locationData.longitude != null) {
        debugPrint(
          "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}",
        );
        await locationBox!.putAll({
          "latitude": locationData.latitude,
          "longitude": locationData.longitude,
        });

        // Navigate to the next screen based on user preferences
        context.nav.pushNamedAndRemoveUntil(
          appSettingsBox.get(AppConstants.hasSeenSplashScreen) != null
              ? Routes.dashboardScreen
              : Routes.onBoardingScreen,
          (route) => false,
        );
      } else {
        // Navigate to the next screen based on user preferences
        context.nav.pushNamedAndRemoveUntil(
          appSettingsBox.get(AppConstants.hasSeenSplashScreen) != null
              ? Routes.dashboardScreen
              : Routes.onBoardingScreen,
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
      showAlertDialog(
        context,
        title: "Error",
        message: "Failed to retrieve location. Please try again.",
        action: () => ph.openAppSettings(),
      );
    }
  }

  Future<void> requestLocationPermission() async {
    print("requestLocationPermission");
    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    debugPrint('serviceEnabled: $serviceEnabled');
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        showAlertDialog(context,
            title: "Location Disabled",
            message: "Please enable location services to continue.",
            action: () {
          location.requestService();
        });
        return;
      }
    }
    PermissionStatus status = await location.hasPermission();
    if (status == PermissionStatus.denied) {
      debugPrint('denied');
      status = await location.requestPermission();
      if (status == PermissionStatus.denied) {
        showAlertDialog(
          context,
          title: "Permission Needed",
          message: "Location permission is required to use this feature.",
          action: () {
            ph.openAppSettings();
            Navigator.of(context).pop(); // Close dialog
          },
        );
        return;
      }
    }
    if (status == PermissionStatus.deniedForever) {
      // Handle permanently denied permission
      showAlertDialog(
        context,
        title: "Permission Denied Forever",
        message:
            "Location permission is permanently denied. Please enable it in the app settings.",
        action: () {
          ph.openAppSettings();
          context.nav.pop();
        },
      );
      return;
    }
    if (status == PermissionStatus.granted) {
      // Permission granted, fetch the location
      debugPrint('Location permission granted.');
      await getLocation(location);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    // Remove the observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _recheckPermission();
    }
  }

  // Recheck permission after app comes back to the foreground
  Future<void> _recheckPermission() async {
    PermissionStatus status = await location.hasPermission();
    if (status == PermissionStatus.granted) {
      // Permission granted, fetch the location
      await getLocation(location);
    } else {
      debugPrint("Location permission not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  "assets/images/png/logo_black.png",
                  // height: 100.h,
                  width: 195.w,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: AnimatedOpacity(
              opacity: startCurveAnimation ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 20,
                width: 1.sw,
                child: SingleChildScrollView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      15,
                      (index) => SizedBox(
                        child: Image.asset(
                          "assets/images/png/curve.png",
                          fit: BoxFit.fitWidth,
                          color: AppColor.primaryColor,
                          width: 1.2.sw,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
