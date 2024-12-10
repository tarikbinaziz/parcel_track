import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/orders/orders_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/order_model/address.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/utils/globalFunction.dart';
import 'package:parcel_track/views/dashboard/order_screen/components/filter.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});

  String processAddess(Address? address) {
    String addres = '';

    if (address?.houseNo != null) {
      addres = '$addres${address?.houseNo ?? ''}, ';
    }
    if (address?.roadNo != null) {
      addres = '$addres${address?.roadNo ?? ''}, ';
    }
    if (address?.block != null) {
      addres = '$addres${address?.block ?? ''}, ';
    }
    if (address?.addressLine != null) {
      addres = '$addres${address?.addressLine ?? ''}, ';
    }
    if (address?.addressLine2 != null) {
      addres = '$addres${address?.addressLine2 ?? ''}, ';
    }
    if (address?.area != null) {
      addres = '$addres${address?.area}, ';
    }
    if (address?.postCode != null) {
      addres = '$addres${address?.postCode}';
    }
    return addres;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (BuildContext context, Box authBox, Widget? child) {
          return authBox.get(AppConstants.authToken) == null
              ? const _UnSignMyOrder()
              : Column(
                  children: [
                    CommonAppBar(
                      title: S.of(context).myOrderTitle,
                      isBackButtonVisible: false,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const FilterBottomSheet(),
                          );
                        },
                        child: Container(
                          height: 44.r,
                          width: 44.r,
                          padding: const EdgeInsets.all(10).r,
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? AppColor.cardBlackBg
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.borderColor,
                              width: 1,
                            ),
                          ),
                          child: SvgPicture.asset("assets/svgs/sorting.svg"),
                        ),
                      ),
                    ),
                    10.ph,
                    Expanded(
                      child: ref.watch(orderListProvider).when(
                            data: (orderList) {
                              return orderList.isEmpty
                                  ? Center(
                                      child: Text(S.of(context).noOrderFound),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.r, vertical: 8.r),
                                      itemCount: orderList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.nav.pushNamed(
                                              Routes.orderDetails,
                                              arguments: orderList[index],
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(16.r),
                                            margin:
                                                EdgeInsets.only(bottom: 8.r),
                                            decoration: BoxDecoration(
                                              color: context.isDarkMode
                                                  ? AppColor.cardBlackBg
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                color: AppColor.borderColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                _orderInfo(
                                                    title:
                                                        S.of(context).bookingId,
                                                    value: orderList[index]
                                                            .orderCode ??
                                                        '',
                                                    isHeader: true),
                                                10.ph,
                                                _orderInfo(
                                                  title: S
                                                      .of(context)
                                                      .serviceSchedule,
                                                  value: orderList[index]
                                                          .orderedAt ??
                                                      '',
                                                ),
                                                10.ph,
                                                _orderInfo(
                                                  title: S.of(context).status,
                                                  value: orderList[index]
                                                          .orderStatus ??
                                                      '',
                                                  isStatus: true,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 16.0),
                                                  child: CustomPaint(
                                                    size: const Size(
                                                        double.infinity, 1),
                                                    painter:
                                                        DottedLinePainter(),
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 4,
                                                        top: 2,
                                                      ).r,
                                                      child: SvgPicture.asset(
                                                        "assets/svgs/location.svg",
                                                        height: 15,
                                                        width: 15,
                                                      ),
                                                    ),
                                                    10.pw,
                                                    Expanded(
                                                      child: Text(
                                                        processAddess(
                                                            orderList[index]
                                                                .address),
                                                        style: AppTextStyle
                                                            .normalBody
                                                            .copyWith(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: const Color(
                                                              0xff475569),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                            error: (e, s) {
                              return Center(
                                child: Text(
                                  S.of(context).errorText(
                                        s.toString(),
                                      ), // Localized error text
                                  style: AppTextStyle.normalBody.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    ),
                    60.ph,
                  ],
                );
        },
      ),
    );
  }

  Widget _orderInfo(
      {required String title,
      required String value,
      bool isHeader = false,
      bool isStatus = false}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.largeBody.copyWith(
                fontSize: 14.sp,
                fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                color: const Color(0xff6B7280),
              ),
            ),
            const Spacer(),
            !isStatus
                ? Text(
                    value,
                    style: AppTextStyle.largeBody.copyWith(
                      fontSize: 14.sp,
                      fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                    ),
                  )
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                    decoration: BoxDecoration(
                      color: GlobalFunction.getStatusColor(value),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Text(
                      value,
                      style: AppTextStyle.largeBody.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Set the color of the dots
      ..strokeWidth = 0.5 // Set the width of the dots
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5.0;
    const double dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _UnSignMyOrder extends StatelessWidget {
  const _UnSignMyOrder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 104.h,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: const Border(
                bottom: BorderSide(
                  color: AppColor.borderColor,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                children: [
                  50.ph,
                  Text(
                    S.of(context).myOrderTitle,
                    style: AppTextStyle.title,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/png/not_found.png'),
                Text(
                  S.of(context).yourNotSignedIn,
                  style: AppTextStyle.normalBody.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                35.ph,
                SizedBox(
                  width: 200.w,
                  child: CustomButton(
                    text: S.of(context).login,
                    buttonColor: AppColor.primaryColor,
                    onPressed: () {
                      context.nav.pushNamed(Routes.login);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
