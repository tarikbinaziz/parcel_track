import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/config/theme.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/views/dashboard/home_screen/logic/providers.dart';

class ScheduleDeliveryScreen extends ConsumerStatefulWidget {
  const ScheduleDeliveryScreen({super.key});

  @override
  ConsumerState<ScheduleDeliveryScreen> createState() =>
      _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState
    extends ConsumerState<ScheduleDeliveryScreen> {
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
                      Text(
                        "Schedule Delivery",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      buildLocationTile(
                        icon: Icons.location_on,
                        title: "Pickup Location",
                        address: "32 Samwell Sq, Chevron",
                        iconColor: Colors.red,
                      ),
                      SizedBox(height: 16.h),
                      buildLocationTile(
                        icon: Icons.location_on,
                        title: "Delivery Location",
                        address: "21b, Karimu Kotun Street, Victoria Island",
                        iconColor: Colors.green,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.h),
                                FormBuilderTextField(
                                  name: 'phone',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  style: AppTextStyle.normalBody,
                                  decoration: AppTheme.inputDecoration
                                      .copyWith(labelText: "Enter Date"),
                                  textInputAction: TextInputAction.next,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.minLength(6,
                                        errorText:
                                            S.of(context).entravalidphnnmbr),
                                    FormBuilderValidators.maxLength(12,
                                        errorText:
                                            S.of(context).entravalidphnnmbr),
                                    FormBuilderValidators.required()
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.h),
                                FormBuilderTextField(
                                  name: 'phone',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  style: AppTextStyle.normalBody,
                                  decoration: AppTheme.inputDecoration
                                      .copyWith(labelText: "Enter Time"),
                                  textInputAction: TextInputAction.next,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.minLength(6,
                                        errorText:
                                            S.of(context).entravalidphnnmbr),
                                    FormBuilderValidators.maxLength(12,
                                        errorText:
                                            S.of(context).entravalidphnnmbr),
                                    FormBuilderValidators.required()
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Vehicle Type",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildVehicleOption(
                              onTap: () {
                                ref
                                    .read(selectedVehicleProvider.notifier)
                                    .state = "Bike";
                              },
                              isSelected:
                                  ref.watch(selectedVehicleProvider) == "Bike",
                              icon: FontAwesomeIcons.motorcycle,
                              label: "Bike"),
                          buildVehicleOption(
                              onTap: () {
                                ref
                                    .read(selectedVehicleProvider.notifier)
                                    .state = "Car";
                              },
                              isSelected:
                                  ref.watch(selectedVehicleProvider) == "Car",
                              icon: FontAwesomeIcons.carSide,
                              label: "Car"),
                          buildVehicleOption(
                              onTap: () {
                                ref
                                    .read(selectedVehicleProvider.notifier)
                                    .state = "Truck";
                              },
                              isSelected:
                                  ref.watch(selectedVehicleProvider) == "Truck",
                              icon: FontAwesomeIcons.truck,
                              label: "Truck"),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      CustomButton(
                          onPressed: () {
                            context.nav.pushNamed(Routes.detailsScreen);
                          },
                          text: "Next")
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
