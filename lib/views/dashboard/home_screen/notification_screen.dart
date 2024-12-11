import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Payment Received',
      'subtitle': 'Your payment of \$150 has been processed successfully.',
      'time': '2 mins ago',
    },
    {
      'title': 'Delivery Update',
      'subtitle': 'Your package is on its way and will arrive soon.',
      'time': '10 mins ago',
    },
    {
      'title': 'Courier Assigned',
      'subtitle': 'Allan Smith has been assigned to your delivery.',
      'time': '1 hour ago',
    },
    {
      'title': 'Delivery Completed',
      'subtitle': 'Your package has been successfully delivered.',
      'time': 'Yesterday',
    },
    {
      'title': 'Delivery Update',
      'subtitle': 'Your package is on its way and will arrive soon.',
      'time': '10 mins ago',
    },
    {
      'title': 'Courier Assigned',
      'subtitle': 'Allan Smith has been assigned to your delivery.',
      'time': '1 hour ago',
    },
    {
      'title': 'Delivery Completed',
      'subtitle': 'Your package has been successfully delivered.',
      'time': 'Yesterday',
    },
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text('Notifications', style: AppTextStyle.title),
      ),
      // make staggered animation

      body: AnimationLimiter(
        child: Padding(
          padding: EdgeInsets.only(bottom: 24.0.h),
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColor.cardLightBg,
                          child: Icon(
                            size: 16.w,
                            Icons.notifications,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        title: Text(
                          notification['title']!,
                          style: AppTextStyle.title.copyWith(fontSize: 14.sp),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification['subtitle']!,
                                style: AppTextStyle.normalBody
                                    .copyWith(fontSize: 14.sp)),
                            const SizedBox(height: 4.0),
                            Text(
                              notification['time']!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
