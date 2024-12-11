import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryDetailsScreen extends ConsumerStatefulWidget {
  String status;
  DeliveryDetailsScreen({super.key, required this.status});

  @override
  ConsumerState<DeliveryDetailsScreen> createState() =>
      _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends ConsumerState<DeliveryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Details',
          style: AppTextStyle.title,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.greyBackgroundColor,
                        radius: 30.0.r,
                        child: const Icon(Icons.person,
                            color: AppColor.primaryColor),
                      ),
                      SizedBox(width: 16.0.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dev Tarik',
                              style: TextStyle(
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '124 Deliveries',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.amber, size: 14.0.w),
                                Icon(Icons.star,
                                    color: Colors.amber, size: 14.0.w),
                                Icon(Icons.star,
                                    color: Colors.amber, size: 14.0.w),
                                Icon(Icons.star,
                                    color: Colors.amber, size: 14.0.w),
                                Icon(Icons.star_half,
                                    color: Colors.amber, size: 14.0.w),
                                SizedBox(width: 8.0.w),
                                const Text('4.1'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: widget.status == "Completed"
                                  ? AppColor.completed
                                  : widget.status == "Pending"
                                      ? Colors.orange
                                      : widget.status == "Cancelled"
                                          ? Colors.red
                                          : widget.status == "Delivering"
                                              ? Colors.blue
                                              : widget.status == "Processing"
                                                  ? Colors.purple
                                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              widget.status,
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 8.0.w),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.cardLightBg,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.phone,
                                  color: AppColor.primaryColor,
                                  size: 18.w,
                                ),
                                onTap: () {
                                  //make url launch phone call
                                  makePhoneCall();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0.h),

              Row(
                children: [
                  const Icon(Icons.place, color: Colors.red),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup Location',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text('32 Samwell Sq, Chevron'),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: AppColor.cardLightBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delivery_dining, color: Colors.teal),
                      )),
                ],
              ),
              SizedBox(height: 16.0.h),
              const Row(
                children: [
                  Icon(Icons.place, color: Colors.green),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Location',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text('21b, Karimu Kotun Street, Victoria Island'),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.0.h),

              // Additional Details
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What you are sending: ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text('Electronics/Gadgets'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recipient:',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text('Dev Tarik'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Recipient contact number:',
                style: TextStyle(color: Colors.grey),
              ),
              const Text('+880 1641586586'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment:', style: TextStyle(color: Colors.grey)),
                      Text('Card'),
                    ],
                  ),
                  SizedBox(height: 8.0.h),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estimated fee:',
                          style: TextStyle(color: Colors.grey)),
                      Text('৳20'),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 24.0.h),
              const Text(
                'Pickup Images:',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8.0.h),

              Row(children: [
                Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColor.cardLightBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.photo, color: Colors.grey),
                ),
                16.pw,
                Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: AppColor.cardLightBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.photo, color: Colors.grey),
                ),
              ]),
            ],
          )

          // // Edit and Submit Buttons
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Edit Details',
          //         style: TextStyle(
          //           color: Colors.teal,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          ),
    );
  }

  void makePhoneCall() async {
    final phoneNumber =
        Uri.parse('tel:+8801641586586'); // The phone number to call
    if (await canLaunchUrl(phoneNumber)) {
      await launchUrl(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Widget buildLocationTile(
      {required IconData icon,
      required String title,
      required String address,
      required Color iconColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColor.cardLightBg,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildVehicleOption(
      {required IconData icon,
      required String label,
      bool isSelected = false,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColor.primaryColor : AppColor.cardLightBg,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(24.0.r),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
