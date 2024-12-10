import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/misc/enums.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/utils/extensions.dart';

class PaymentMethodSection extends ConsumerWidget {
  const PaymentMethodSection({super.key});

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
            S.of(context).paymentMethod,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          10.ph,
          _PaymentMethodContainer(
            ontap: () {
              ref.read(selectedPaymentTypeProvider.notifier).state =
                  PaymentType.cod;
            },
            icon: "assets/images/png/cod_icon.png",
            isselected:
                ref.watch(selectedPaymentTypeProvider) == PaymentType.cod,
            type: S.of(context).cashOnDelivery, // Localized type
          ),
          8.ph,
          _PaymentMethodContainer(
            ontap: () {
              // ref.read(selectedPaymentTypeProvider.notifier).state =
              //     PaymentType.online;
              EasyLoading.showError("Online Payment is not available yet");
            },
            icon: "assets/images/png/online_payment_icon.png",
            isselected:
                ref.watch(selectedPaymentTypeProvider) == PaymentType.online,
            type: S.of(context).onlinePayment, // Localized type
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodContainer extends StatelessWidget {
  const _PaymentMethodContainer({
    required this.icon,
    required this.type,
    required this.isselected,
    this.ontap,
  });
  final String icon;
  final String type;
  final bool isselected;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColor.cardBlackBg : Colors.white,
          border: Border.all(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    width: 48.w,
                    height: 48.h,
                    fit: BoxFit.cover,
                  ),
                  8.pw,
                  Text(
                    type,
                    style: AppTextStyle.normalBody.copyWith(),
                  ),
                ],
              ),
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isselected ? AppColor.primaryColor : Colors.grey,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: isselected ? AppColor.primaryColor : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
