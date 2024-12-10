import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/cart_models/hive_cart_model.dart';
import 'package:laundrymart_flutter/models/others.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';
import 'package:laundrymart_flutter/views/dashboard/home_screen/components/home_appBar.dart';
import 'package:laundrymart_flutter/views/dashboard/service_screen/components/product_section.dart';
import 'package:laundrymart_flutter/views/dashboard/service_screen/components/varient_section.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.arg});
  final ServiceArg arg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          _AppBar(title: S.of(context).product),
          // Varient Section
          VarientSection(arg: arg),
          // Product Section
          ProductSection(
            serviceID: arg.serviceID,
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable:
              Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
          builder: (context, Box<HiveCartModel> cartBox, child) {
            return cartBox.length != 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        height: 60.h,
                        padding: EdgeInsets.symmetric(horizontal: 65.h),
                        child: CustomButton(
                          onPressed: () {
                            context.nav.pushNamed(Routes.cartScreen);
                          },
                          isArrowRight: true,
                          text: "Go to Cart",
                        ),
                      ),
                      10.ph,
                    ],
                  )
                : const SizedBox.shrink();
          }),
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
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.black : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: context.isDarkMode ? AppColor.black : AppColor.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            44.ph,
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
                20.pw,
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box<HiveCartModel>(AppConstants.cartBox)
                            .listenable(),
                    builder: (context, Box<HiveCartModel> cartBox, child) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.nav.pushNamed(Routes.cartScreen);
                            },
                            child: const HomeTopContainer(
                              icon: "assets/svgs/cart_icon.svg",
                            ),
                          ),
                          Positioned(
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
                          )
                        ],
                      );
                    }),
              ],
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
