import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.isRead,
  });

  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      decoration: BoxDecoration(
        color: isRead ? Colors.white : AppColor.primaryColor.withOpacity(0.1),
        border: const Border(
          bottom: BorderSide(
            color: AppColor.greyBackgroundColor,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10.r,
            width: 10.r,
            margin: const EdgeInsets.only(top: 4).r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRead ? Colors.transparent : AppColor.primaryColor,
            ),
          ),
          8.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your order has been shipped to the delivery man. The delivery man will call you when he arrives at your location.",
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                8.ph,
                Text(
                  "12 Oct, 2023 - 12:00 PM",
                  style: AppTextStyle.smallBody.copyWith(
                    color: const Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
