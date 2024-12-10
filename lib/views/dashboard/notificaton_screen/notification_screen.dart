import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/utils/extensions.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (BuildContext context, Box authBox, Widget? child) {
          // TODO: Check Notification Screen and comment code also
          // return authBox.get(AppConstants.authToken) == null
          //     ? const _UnSignNotification()
          //     : Column(
          //         children: [
          //           const CommonAppBar(
          //             title: "Notification",
          //             isBackButtonVisible: false,
          //           ),
          //           1.5.ph,
          //           const NotificationFilterList(),
          //           Expanded(
          //             child: ListView.builder(
          //               itemCount: 50,
          //               padding: const EdgeInsets.symmetric(vertical: 3).r,
          //               itemBuilder: (context, index) {
          //                 return NotificationCard(
          //                   isRead: index % 2 == 0 ? true : false,
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       );
          return const _UnSignNotification();
        },
      ),
    );
  }
}

class _UnSignNotification extends StatelessWidget {
  const _UnSignNotification();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 104.h,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: const Border(
              bottom: BorderSide(
                color: AppColor.borderColor,
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                50.ph,
                Text(
                  "Notifications",
                  style: AppTextStyle.title,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Notifications Found',
                ),
                20.ph,
                SizedBox(
                  height: 154.h,
                  width: 154.w,
                  child: Image.asset(
                    'assets/images/png/hibernation.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
