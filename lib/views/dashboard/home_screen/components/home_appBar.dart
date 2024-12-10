import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/others_controller/others_controller.dart';
import 'package:laundrymart_flutter/models/cart_models/hive_cart_model.dart';
import 'package:laundrymart_flutter/models/store_model/address.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({
    super.key,
  });

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
    return Container(
      width: MediaQuery.of(context).size.width,
      color: context.isDarkMode ? Colors.black : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          44.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                Theme.of(context).scaffoldBackgroundColor == AppColor.grayBlackBG
                    ? "assets/images/png/logo_white.png"
                    : "assets/images/png/logo_black.png",
                height: 60.h,
              ),
              5.pw,
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.nav.pushNamed(Routes.cartScreen);
                    },
                    child: const HomeTopContainer(
                      icon: "assets/svgs/cart_icon.svg",
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable:
                        Hive.box<HiveCartModel>(AppConstants.cartBox)
                            .listenable(),
                    builder: (context, Box<HiveCartModel> cartBox, child) {
                      return Positioned(
                        right: 0,
                        child: Container(
                          width: 16.h,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              cartBox.length.toString(),
                              style: AppTextStyle.normalBody.copyWith(
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
          10.ph,
          ValueListenableBuilder(
            valueListenable: Hive.box(AppConstants.authBox).listenable(),
            builder: (context, auth, _) {
              return auth.get(AppConstants.authToken) == null
                  ? const SizedBox()
                  : ref.watch(addressListProvider).when(
                        data: (list) {
                          Address? address = list.isNotEmpty
                              ? list.firstWhere((element) {
                                  return element.isDefault == 1;
                                })
                              : null;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8)
                                .r,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1),
                              borderRadius: BorderRadius.circular(21.r),
                              color: context.isDarkMode
                                  ? AppColor.grayBlackBG
                                  : AppColor.greyBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 16.r,
                                ),
                                5.pw,
                                Expanded(
                                  child: Text(
                                    address != null
                                        ? processAddess(address)
                                        : "No Address Found",
                                    style: AppTextStyle.normalBody.copyWith(
                                      color: const Color(0xff6B7280),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        error: (e, s) => const Text("Failed to load address"),
                        loading: () => const SizedBox(),
                      );
            },
          ),
          10.ph,
        ],
      ),
    );
  }
}

class HomeTopContainer extends StatelessWidget {
  const HomeTopContainer({
    super.key,
    required this.icon,
  });
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(21.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}
