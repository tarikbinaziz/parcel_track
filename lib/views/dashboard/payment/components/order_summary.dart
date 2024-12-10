import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/cart_controller/cart_controller.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/controllers/others_controller/others_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/utils/extensions.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? currency =
        ref.watch(appSettingDataProvider.notifier).state.currency;
    final cartControllerProvider = ref.watch(cartController);
    // HINT: set delivery charge
    ref.watch(cartController.notifier).setDeliveryCharge(
        charge: ref.watch(orderConditionProvider).deliveryCharge);
    // ref.watch(cartController.notifier).setCuponDiscount(0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).r,
      color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).orderSummary,
            style: AppTextStyle.normalBody.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          10.ph,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            decoration: BoxDecoration(
              color: AppColor.greyBackgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                textField(
                  title: S.of(context).subTotal,
                  value:
                      cartControllerProvider.subTotalAmount.toStringAsFixed(2),
                  currency: currency!,
                ),
                6.ph,
                textField(
                  title: S.of(context).discount,
                  value: cartControllerProvider.cuponDiscountedAmount
                      .toStringAsFixed(2),
                  currency: currency,
                ),
                const Divider(),
                textField(
                  title: S.of(context).total,
                  value: cartControllerProvider.totalAmount.toStringAsFixed(2),
                  currency: currency,
                ),
                6.ph,
                textField(
                  title: S.of(context).deliveryCharge,
                  value:
                      cartControllerProvider.deliveryCharge.toStringAsFixed(2),
                  currency: currency,
                ),
                const Divider(),
                textField(
                  title: S.of(context).payableAmount,
                  value:
                      cartControllerProvider.payableAmount.toStringAsFixed(2),
                  currency: currency,
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row textField(
      {required String title,
      required String value,
      bool isTotal = false,
      required String currency}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.normalBody.copyWith(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          "$currency$value",
          style: AppTextStyle.normalBody.copyWith(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
