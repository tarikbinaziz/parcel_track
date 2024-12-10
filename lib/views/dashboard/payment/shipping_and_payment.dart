import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/components/common_appBar.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/components/cupon_code.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/components/order_summary.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/components/payment_method_section.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/components/place_order_nav_button.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/components/shipping_address.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/components/shipping_schedule.dart';

class ShippingAndPayment extends StatelessWidget {
  const ShippingAndPayment({super.key, required this.isReOrder});

  final bool isReOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(
            title: S.of(context).shippingAndPayment,
          ),
          10.ph,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                const ShippingSchedule(),
                10.ph,
                const ShippingAddress(),
                10.ph,
                const CuponCodeSection(),
                const OrderSummary(),
                10.ph,
                const PaymentMethodSection(),
                30.ph,
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: PlaceOrderNavButton(isReOrder: isReOrder),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 134.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColor.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            54.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      20.pw,
                      Text(
                        title,
                        style: AppTextStyle.normalBody
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
