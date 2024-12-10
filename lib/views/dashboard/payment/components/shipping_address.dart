import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/others_controller/others_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/store_model/address.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class ShippingAddress extends ConsumerWidget {
  const ShippingAddress({super.key});

  String processAddess(Address address) {
    String addres = '';

    if (address.houseNo != null) {
      addres = '$addres${address.houseNo}, ';
    }
    if (address.roadNo != null) {
      addres = '$addres${address.roadNo}, ';
    }
    if (address.block != null) {
      addres = '$addres${address.block}, ';
    }
    if (address.addressLine != null) {
      addres = '$addres${address.addressLine}, ';
    }
    if (address.addressLine2 != null) {
      addres = '$addres${address.addressLine2}, ';
    }
    if (address.area != null) {
      addres = '$addres${address.area}, ';
    }
    if (address.postCode != null) {
      addres = '$addres${address.postCode}';
    }
    return addres;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(addressListProvider).when(
          data: (list) {
            Address? address = list.isNotEmpty
                ? list.firstWhere((element) => element.isDefault == 1)
                : null;
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
              color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).shippingAddress,
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  16.ph,
                  address == null
                      ? SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: CustomButton(
                            onPressed: () {
                              context.nav.pushNamed(Routes.manageAddress);
                            },
                            text: S.of(context).addAddress,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16)
                              .r,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.borderColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10).r,
                                child: SvgPicture.asset(
                                  "assets/svgs/location.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              10.pw,
                              Expanded(
                                child: ValueListenableBuilder(
                                    valueListenable:
                                        Hive.box(AppConstants.authBox)
                                            .listenable(),
                                    builder: (context, Box authBox, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 2)
                                                        .r,
                                                decoration: BoxDecoration(
                                                  color: AppColor.grayBlackBG,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Text(
                                                  S
                                                      .of(context)
                                                      .home
                                                      .toUpperCase(),
                                                  style: AppTextStyle.smallBody
                                                      .copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.nav.pushNamed(
                                                      Routes.manageAddress);
                                                },
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10)
                                                      .r,
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      color:
                                                          AppColor.primaryColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
                                                  ),
                                                ),
                                                child: Text(
                                                  S.of(context).change,
                                                  style: AppTextStyle.normalBody
                                                      .copyWith(
                                                    color:
                                                        AppColor.primaryColor,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          2.ph,
                                          Text(
                                            authBox.get(AppConstants.userData)?[
                                                    'name'] ??
                                                "",
                                            style: AppTextStyle.normalBody
                                                .copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          2.ph,
                                          Text(
                                            authBox.get(AppConstants.userData)?[
                                                    'mobile'] ??
                                                "",
                                            style: AppTextStyle.normalBody
                                                .copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff475569),
                                            ),
                                          ),
                                          2.ph,
                                          Text(
                                            processAddess(address),
                                            style: AppTextStyle.normalBody
                                                .copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff475569),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              )
                            ],
                          ),
                        )
                ],
              ),
            );
          },
          error: (e, s) {
            return Text("Error: $e");
          },
          loading: () => const SizedBox(),
        );
  }
}
