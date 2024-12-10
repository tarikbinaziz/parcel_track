import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/theme.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class ShippingSchedule extends ConsumerWidget {
  const ShippingSchedule({super.key});

  void pickDate(BuildContext context, WidgetRef ref) {
    showDatePicker(
      context: context,
      initialDate: ref.read(pickupDateProvider) ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    ).then((value) {
      if (value != null) {
        ref.read(pickupDateProvider.notifier).state = value;
      }
    });
  }

  void pickDeliveryDate(BuildContext context, WidgetRef ref) {
    showDatePicker(
      context: context,
      initialDate: ref.read(pickupDateProvider)!.add(const Duration(days: 1)),
      firstDate: ref.read(pickupDateProvider)!.add(const Duration(days: 1)),
      lastDate: ref.read(pickupDateProvider)!.add(const Duration(days: 30)),
    ).then((value) {
      if (value != null) {
        ref.read(deliveryDateProvider.notifier).state = value;
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).shippingSchedule,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          16.ph,
          Row(
            children: [
              Expanded(
                child: TextField(
                  onTap: () => pickDate(context, ref),
                  controller: TextEditingController(
                    text: ref.watch(pickupDateProvider) != null
                        ? ref.watch(pickupDateProvider).toString().split(" ")[0]
                        : "",
                  ),
                  readOnly: true,
                  decoration: AppTheme.inputDecoration.copyWith(
                    hintText: 'dd/mm/yyyy',
                    labelText: S.of(context).pickupDate,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/svgs/calendar.svg"),
                    ),
                  ),
                ),
              ),
              20.pw,
              Expanded(
                child: TextField(
                  onTap: () {
                    if (ref.read(pickupDateProvider) != null) {
                      pickDeliveryDate(context, ref);
                    } else {
                      EasyLoading.showError(
                          S.of(context).selectPickupDateFirst);
                    }
                  },
                  controller: TextEditingController(
                    text: ref.watch(deliveryDateProvider) != null
                        ? ref
                            .watch(deliveryDateProvider)
                            .toString()
                            .split(" ")[0]
                        : "",
                  ),
                  readOnly: true,
                  decoration: AppTheme.inputDecoration.copyWith(
                    hintText: 'dd/mm/yyyy',
                    labelText: S.of(context).deliveryDate,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: const BorderSide(color: AppColor.borderColor),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/svgs/calendar.svg"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
