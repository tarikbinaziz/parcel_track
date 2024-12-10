import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  late final Animation<Offset> _offsetAnimation =
      Tween<Offset>(begin: const Offset(0, 9), end: const Offset(0, 0)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  @override
  void initState() {
    super.initState();
    _animationController.forward().whenComplete(() {
      goRoute();
    });
  }

  void goRoute() {
    Timer(
      const Duration(seconds: 1),
      () {
        context.nav
            .pushNamedAndRemoveUntil(Routes.dashboardScreen, (route) => false);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _offsetAnimation,
        child: Image.asset(
          "assets/images/png/logo_black.png",
          width: 120.w,
        ),
      ),
    );
  }
}
