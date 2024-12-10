import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryColor.withOpacity(0.1)),
              child: const Icon(Icons.person, color: AppColor.primaryColor)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style:
                      AppTextStyle.normalBody.copyWith(color: Colors.grey[600]),
                ),
                Text(
                  "Dev Tarik",
                  style: AppTextStyle.title,
                ),
              ],
            ),
            IconButton(
              icon: Image.asset(
                "assets/images/png/notification.png",
                height: 24.h,
                width: 24.w,
              ),
              onPressed: () {},
            ),
          ],
        ),
        actions: const [
          // CircleAvatar(
          //   backgroundColor: Colors.blue,
          //   child: Text("DE", style: TextStyle(color: Colors.white)),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What would you like to do?",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 16.h),
              // Options
              Column(
                children: [
                  SizedBox(
                    height: 124.h,
                    width: double.infinity,
                    child: _buildOptionCard(
                      context,
                      title: "Instant Delivery",
                      description:
                          "Courier takes only your package and delivers instantly",
                      icon: Icons.flash_on,
                      backgroundColor: AppColor.cardLightPrimaryBg,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 124.h,
                    width: double.infinity,
                    child: _buildOptionCard(
                      context,
                      title: "Schedule Delivery",
                      description:
                          "Courier comes to pick up on your specified date and time",
                      icon: Icons.schedule,
                      backgroundColor: AppColor.greyBackgroundColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // History Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History",
                    style: AppTextStyle.title.copyWith(
                        color: AppColor.primaryColor, fontSize: 16.sp),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "View all",
                      style: AppTextStyle.title.copyWith(
                          color: AppColor.primaryColor, fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildHistoryCard(
                    context,
                    orderId: "ORD1234",
                    recipient: "Paul Pogba",
                    location: "Maryland busstop, Anthony Ikeja",
                    date: "12 January 2020, 2:43PM",
                    status: "Completed",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required Color backgroundColor}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 30.sp),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(height: 5.h),
          Text(
            description,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
        ],
      ),
    );
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
                    color: AppColor.completed,
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
                color: Colors.green,
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
}
