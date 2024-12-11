import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class CourierDetailsScreen extends ConsumerStatefulWidget {
  const CourierDetailsScreen({super.key});

  @override
  ConsumerState<CourierDetailsScreen> createState() =>
      _CourierDetailsScreenState();
}

class _CourierDetailsScreenState extends ConsumerState<CourierDetailsScreen> {
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
              top: 24.h,
              left: 16.w,
              child: GestureDetector(
                onTap: () => context.nav.pop(),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              top: 60.h,
              left: 0.w,
              right: 0,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70.w),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Your percel is on the way",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.3,
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
                      const SizedBox(height: 16.0),

                      // Courier Status
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your courier is on his way!',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2 mins away',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.0.h),

                      // Courier Details
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColor.greyBackgroundColor,
                                radius: 30.0,
                                child: Icon(Icons.person,
                                    color: AppColor.primaryColor),
                              ),
                              const SizedBox(width: 16.0),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dev Tarik',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '124 Deliveries',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.0),
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.0),
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.0),
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20.0),
                                        Icon(Icons.star_half,
                                            color: Colors.amber, size: 20.0),
                                        SizedBox(width: 8.0),
                                        Text('4.1'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.cardLightBg,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.phone,
                                      color: Colors.green),
                                  onPressed: () {
                                    //make url launch phone call
                                    makePhoneCall();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      40.ph,

                      // Cancel Button
                      TextButton(
                        onPressed: () {
                          context.nav.pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
