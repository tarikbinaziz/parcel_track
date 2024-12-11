import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text("Delivery History", style: AppTextStyle.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              AnimationLimiter(
                child: ListView.builder(
                  itemCount: historyData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = historyData[index];

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              context.nav.pushNamed(
                                Routes.deliveryDetailsScreen,
                                arguments: item["status"],
                              );
                            },
                            child: _buildHistoryCard(
                              context,
                              orderId: item["orderId"]!,
                              recipient: item["recipient"]!,
                              location: item["location"]!,
                              date: item["date"]!,
                              status: item["status"]!,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
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
                  "History",
                  style: AppTextStyle.title,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildHistoryCard(BuildContext context,
    {required String orderId,
    required String recipient,
    required String location,
    required String date,
    required String status}) {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.symmetric(vertical: 8.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    child: Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Section
          Column(
            children: [
              Icon(
                Icons
                    .delivery_dining, // Replace with a courier/bike icon if needed
                color: Colors.teal,
                size: 24.sp,
              ),
              SizedBox(height: 4.h),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: status == "Completed"
                      ? AppColor.completed
                      : status == "Pending"
                          ? Colors.orange
                          : status == "Cancelled"
                              ? Colors.red
                              : status == "Delivering"
                                  ? Colors.blue
                                  : status == "Processing"
                                      ? Colors.purple
                                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          // Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderId,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Recipient: $recipient",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Drop off",
                  style: TextStyle(fontSize: 12.sp, color: Colors.teal),
                ),
                Text(
                  location,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 4.h),
                Text(
                  date,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Status Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: status == "Completed"
                  ? AppColor.completed
                  : status == "Pending"
                      ? Colors.orange
                      : status == "Cancelled"
                          ? Colors.red
                          : status == "Delivering"
                              ? Colors.blue
                              : status == "Processing"
                                  ? Colors.purple
                                  : Colors.grey,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              status,
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

final List<Map<String, String>> historyData = [
  {
    "orderId": "ORD5678",
    "recipient": "Lionel Messi",
    "location": "Victoria Island, Lagos",
    "date": "13 January 2020, 4:00PM",
    "status": "Completed",
  },
  {
    "orderId": "ORD5678",
    "recipient": "Lionel Messi",
    "location": "Victoria Island, Lagos",
    "date": "13 January 2020, 4:00PM",
    "status": "Pending",
  },
  {
    "orderId": "ORD5678",
    "recipient": "Lionel Messi",
    "location": "Victoria Island, Lagos",
    "date": "13 January 2020, 4:00PM",
    "status": "Cancelled",
  },
  {
    "orderId": "ORD9101",
    "recipient": "Cristiano Ronaldo",
    "location": "Ikoyi, Lagos",
    "date": "14 January 2020, 10:00AM",
    "status": "Delivering",
  },
  {
    "orderId": "ORD9101",
    "recipient": "Cristiano Ronaldo",
    "location": "Ikoyi, Lagos",
    "date": "14 January 2020, 10:00AM",
    "status": "Pending",
  },
  {
    "orderId": "ORD9101",
    "recipient": "Cristiano Ronaldo",
    "location": "Ikoyi, Lagos",
    "date": "14 January 2020, 10:00AM",
    "status": "Processing",
  },
];
