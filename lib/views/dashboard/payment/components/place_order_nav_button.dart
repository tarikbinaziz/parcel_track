import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/cart_controller/cart_controller.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/controllers/orders/orders_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/cart_models/hive_cart_model.dart';
import 'package:parcel_track/models/order_model/order_model.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class PlaceOrderNavButton extends ConsumerWidget {
  const PlaceOrderNavButton({
    super.key,
    this.isReOrder = false,
  });

  final bool isReOrder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? currency =
        ref.watch(appSettingDataProvider.notifier).state.currency;
    final isLoading = ref.watch(addOrderProvider);
    final reOrderLoading = ref.watch(reOrderProvider);
    return Container(
      height: 115.h,
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.black : Colors.white,
        border: Border(
          top: BorderSide(
            color: context.isDarkMode
                ? AppColor.grayBlackBG
                : AppColor.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).payableAmount, // Localized label
                style: AppTextStyle.normalBody.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color(0xff6B7280),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final cartControllerProvider = ref.watch(cartController);
                  return Text(
                    "$currency${cartControllerProvider.payableAmount.toStringAsFixed(2)}",
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              )
            ],
          ),
          10.ph,
          SizedBox(
            width: double.infinity,
            child: isLoading || reOrderLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    onPressed: () {
                      final cardItemsList =
                          Hive.box<HiveCartModel>(AppConstants.cartBox)
                              .values
                              .toList()
                              .cast<HiveCartModel>();

                      final appSettingsBox =
                          Hive.box(AppConstants.appSettingsBox);

                      if (ref.read(deliveryDateProvider) == null ||
                          ref.read(pickupDateProvider) == null) {
                        EasyLoading.showError(S.of(context).selectShippingDate);
                        return;
                      } else if (ref.read(addressIdProvider) == null) {
                        EasyLoading.showError(S.of(context).selectAddress);
                        return;
                      }

                      List<Map<String, dynamic>> productsArray = [];

                      for (var i = 0; i < cardItemsList.length; i++) {
                        var item = cardItemsList[i];
                        productsArray.add({
                          "id": item.id,
                          "quantity": item.productsQTY,
                        });
                      }

                      Map<String, dynamic> data = {
                        "store_id": appSettingsBox.get(AppConstants.storeId),
                        "pick_date": ref
                            .read(pickupDateProvider)
                            .toString()
                            .split(" ")[0],
                        "delivery_date": ref
                            .read(deliveryDateProvider)
                            .toString()
                            .split(" ")[0],
                        "address_id": ref.read(addressIdProvider),
                        "products": productsArray,
                        "coupon_id": ref.read(couponIdProvider),
                      };

                      if (isReOrder == true) {
                        ref.read(reOrderProvider.notifier).reOrder(data: {
                          "order_id": ref.read(orderIdProvider),
                          "pick_date": ref
                              .read(pickupDateProvider)
                              .toString()
                              .split(" ")[0],
                          "delivery_date": ref
                              .read(deliveryDateProvider)
                              .toString()
                              .split(" ")[0],
                        }).then((value) {
                          if (value != null) {
                            // clear cart
                            Hive.box<HiveCartModel>(AppConstants.cartBox)
                                .clear();
                            ref.invalidate(orderListProvider);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.5),
                              builder: (context) => orderDialog(context, value),
                            );
                          }
                        });
                      } else {
                        ref
                            .read(addOrderProvider.notifier)
                            .addOrder(data: data)
                            .then((value) {
                          if (value != null) {
                            // clear cart
                            Hive.box<HiveCartModel>(AppConstants.cartBox)
                                .clear();
                            ref.invalidate(orderListProvider);
                            ref.read(cartController.notifier).clearFiles();
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.5),
                              builder: (context) => orderDialog(context, value),
                            );
                          }
                        });
                      }
                    },
                    text: S.of(context).placeOrder,
                  ),
          ),
        ],
      ),
    );
  }

  Widget orderDialog(BuildContext context, OrderModel orderModel) {
    return Dialog(
      backgroundColor: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          String? currency =
              ref.watch(appSettingDataProvider.notifier).state.currency;
          return Padding(
            padding: EdgeInsets.only(
                top: 32.h, left: 16.r, right: 16.r, bottom: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 60.r,
                  width: 60.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/svgs/right_circular_icon.svg",
                    colorFilter: const ColorFilter.mode(
                      AppColor.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                20.ph,
                Text(
                  S.of(context).bookedSuccessfully,
                  style: AppTextStyle.largeBody.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                  ),
                ),
                30.ph,
                _bookedInfo(
                  context: context,
                  title: S.of(context).orderId,
                  value: orderModel.data?.order?.orderCode ?? "",
                ),
                10.ph,
                _bookedInfo(
                  context: context,
                  title: S.of(context).pickupDate,
                  value: orderModel.data?.order?.pickDate ?? "",
                ),
                10.ph,
                _bookedInfo(
                  context: context,
                  title: S.of(context).pickupTime,
                  value: orderModel.data?.order?.pickHour ?? "",
                ),
                10.ph,
                _bookedInfo(
                  context: context,
                  title: S.of(context).paymentMethod,
                  value: orderModel.data?.order?.paymentType ?? "",
                ),
                10.ph,
                _bookedInfo(
                  context: context,
                  title: S.of(context).totalAmount,
                  value: orderModel.data?.order?.payableAmount.toString() ?? "",
                  isAmount: true,
                  currency: currency,
                ),
                25.ph,
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref
                          .read(homeScreenIndexProvider.notifier)
                          .update((index) => 2);
                      context.nav.pushNamedAndRemoveUntil(
                        Routes.dashboardScreen,
                        (route) => false,
                      );
                    },
                    text: S.of(context).viewOrder, // Localized button text
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _bookedInfo(
      {required BuildContext context,
      required String title,
      required String value,
      String? currency,
      bool isAmount = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.normalBody.copyWith(
              fontSize: 14.sp,
              color: context.isDarkMode
                  ? AppColor.greyBackgroundColor
                  : AppColor.black.withOpacity(0.6),
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: Text(
            isAmount ? "$currency$value" : value,
            style: AppTextStyle.normalBody.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.isDarkMode ? AppColor.whiteColor : AppColor.black,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
