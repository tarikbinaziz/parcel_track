import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class BottomNavBar extends ConsumerWidget {
  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(homeScreenIndexProvider);
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, -1),
            )
          ],
        ),
        height: Platform.isAndroid
            ? 72.h
            : 72.h + MediaQuery.of(context).viewPadding.bottom,
        child: Padding(
          padding: Platform.isIOS
              ? const EdgeInsets.only(bottom: 16).r
              : EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _text(context).length,
              (index) => GestureDetector(
                onTap: () {
                  ref.read(homeScreenIndexProvider.notifier).state = index;
                },
                child: bottomContainer(
                  isActive: selectedIndex == index,
                  selectedIcon: _selectedIcon[index],
                  unselectedIcon: _unSelectedIcon[index],
                  text: _text(context)[index],
                  index: index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column bottomContainer({
    required bool isActive,
    required String selectedIcon,
    required String unselectedIcon,
    required String text,
    required int index,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isActive ? 40.h : 0.h,
              width: isActive ? 40.h : 0.h,
              decoration: BoxDecoration(
                color: isActive ? AppColor.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(8.r),
            ),
            Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(8.r),
              child: SvgPicture.asset(
                isActive ? selectedIcon : unselectedIcon,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          text,
          style: AppTextStyle.normalBody.copyWith(
            color: isActive ? AppColor.primaryColor : const Color(0xff9CA3AF),
            fontSize: 10.sp,
          ),
        )
      ],
    );
  }

  final List<String> _unSelectedIcon = [
    "assets/svgs/home.svg",
    "assets/svgs/shop.svg",
    "assets/svgs/order.svg",
    "assets/svgs/notification.svg",
    "assets/svgs/user.svg",
  ];
  final List<String> _selectedIcon = [
    "assets/svgs/home_selected.svg",
    "assets/svgs/shop_selected.svg",
    "assets/svgs/order_selected.svg",
    "assets/svgs/notification_selected.svg",
    "assets/svgs/user_selected.svg",
  ];

  List<String> _text(BuildContext context) => [
        S.of(context).home,
        S.of(context).shop,
        S.of(context).order,
        S.of(context).notification,
        S.of(context).profile,
      ];
}
