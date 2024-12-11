import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';

class PaymentListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> paymentData = [
    {
      "orderId": "ORD5678",
      'date': '12/12/2024',
      'amount': 150,
      'status': 'Completed',
    },
    {
      "orderId": "ORD5658",
      'date': '13/12/2024',
      'amount': 200,
      'status': 'Pending',
    },
    {
      "orderId": "ORD56578",
      'date': '14/12/2024',
      'amount': 100,
      'status': 'Cancelled',
    },
    {
      "orderId": "ORD5675",
      'date': '15/12/2024',
      'amount': 250,
      'status': 'Delivering',
    },
    {
      "orderId": "ORD5637",
      'date': '16/12/2024',
      'amount': 180,
      'status': 'Processing',
    },
    {
      "orderId": "ORD56578",
      'date': '14/12/2024',
      'amount': 100,
      'status': 'Cancelled',
    },
    {
      "orderId": "ORD5675",
      'date': '15/12/2024',
      'amount': 250,
      'status': 'Delivering',
    },
    {
      "orderId": "ORD5637",
      'date': '16/12/2024',
      'amount': 180,
      'status': 'Processing',
    },
  ];

  PaymentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          'Payments',
          style: AppTextStyle.title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: AnimationLimiter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 24.0.h),
            child: ListView.builder(
              itemCount: paymentData.length,
              itemBuilder: (context, index) {
                final payment = paymentData[index];
                final status = payment['status'];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Padding(
                          padding: EdgeInsets.all(12.0.r),
                          child: Row(children: [
                            Icon(
                              Icons.payment,
                              color: AppColor.primaryColor,
                              size: 16.w,
                            ),
                            SizedBox(width: 16.0.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order ID: ${payment['orderId']}',
                                        style: AppTextStyle.title.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0.r),
                                          color: status == "Completed"
                                              ? AppColor.primaryColor
                                              : status == "Pending"
                                                  ? Colors.orange
                                                  : status == "Cancelled"
                                                      ? Colors.red
                                                      : status == "Delivering"
                                                          ? Colors.blue
                                                          : status ==
                                                                  "Processing"
                                                              ? Colors.purple
                                                              : Colors.grey,
                                          // shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${payment['status']}',
                                          style:
                                              AppTextStyle.smallBody.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 4.0.h),
                                  Text(
                                    'Date: ${payment['date']}',
                                    style: AppTextStyle.normalBody.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.0.h),
                                  Text(
                                    'Amount: \$${payment['amount']}',
                                    style: AppTextStyle.normalBody.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
