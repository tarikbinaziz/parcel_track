import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class ConfirmDetailsScreen extends ConsumerStatefulWidget {
  const ConfirmDetailsScreen({super.key});

  @override
  ConsumerState<ConfirmDetailsScreen> createState() =>
      _ConfirmDetailsScreenState();
}

class _ConfirmDetailsScreenState extends ConsumerState<ConfirmDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Map view placeholder
            Container(
              // height: 0.4.sh,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/png/map.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 40.h,
              left: 16.w,
              child: GestureDetector(
                onTap: () => context.nav.pop(),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      const Text(
                        'Confirm Details',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Pickup and Delivery Locations,

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
                                child: Icon(Icons.delivery_dining,
                                    color: Colors.teal),
                              )),
                        ],
                      ),
                      const SizedBox(height: 16.0),
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
                                Text(
                                    '21b, Karimu Kotun Street, Victoria Island'),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16.0),

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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Payment:',
                                  style: TextStyle(color: Colors.grey)),
                              Text('Card'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Estimated fee:',
                                  style: TextStyle(color: Colors.grey)),
                              Text('৳20'),
                            ],
                          ),
                        ],
                      ),

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
                      SizedBox(height: 40.h),
                      CustomButton(
                        onPressed: () {
                          context.nav.pushNamed(Routes.courierDetailsScreen);
                        },
                        text: "Look for courier",
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
