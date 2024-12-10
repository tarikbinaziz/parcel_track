import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/cart_controller/cart_controller.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/cart_models/hive_cart_model.dart';
import 'package:parcel_track/models/product_model/product_model.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/views/cart/product_cart.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currency =
        ref.watch(appSettingDataProvider.notifier).state.currency;
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
        builder: (context, Box<HiveCartModel> box, child) {
          final productDataList = cartDataToProductModel(box.values.toList());
          ref
              .watch(cartController.notifier)
              .calculateSubTotal(box.values.toList());
          return Scaffold(
            body: Column(
              children: [
                const CommonAppBar(title: "My Cart"),
                10.ph,
                Expanded(
                  child: productDataList.isEmpty
                      ? Center(
                          child: Text(
                            "Your cart is Empty!",
                            style: AppTextStyle.normalBody,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: productDataList.length,
                          itemBuilder: (context, index) {
                            return ProductCart(
                              productModel: productDataList[index],
                            );
                          },
                        ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 90.h,
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
              decoration: BoxDecoration(
                  color: context.isDarkMode ? Colors.black : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColor.cardBlackBg
                            : AppColor.greyBackgroundColor,
                        borderRadius: BorderRadius.circular(48).r,
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const PricingInfo();
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final cartData = ref.watch(cartController);
                                return Text(
                                  "$currency${cartData.subTotalAmount.toStringAsFixed(2)}",
                                  style: AppTextStyle.title.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              },
                            ),
                            Text(
                              S.of(context).viewDetails,
                              style: AppTextStyle.smallBody.copyWith(
                                color: const Color(0xff9CA3AF),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  12.pw,
                  Expanded(
                    flex: 4,
                    child: CustomButton(
                      onPressed: () {
                        if (productDataList.isEmpty) {
                          EasyLoading.showError(S.of(context).cartEmptyError);
                          return;
                        }
                        if (Hive.box(AppConstants.authBox)
                                .get(AppConstants.authToken) ==
                            null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Are You Sure Want To Checkout?",
                                    style: AppTextStyle.normalBody.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  5.ph,
                                  Text(
                                    "You need to login first.",
                                    style: AppTextStyle.normalBody.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.nav.pushNamed(Routes.login);
                                  },
                                  child: const Text("Login"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        context.nav.pushNamed(
                          Routes.shippingPayment,
                          arguments: false,
                        );
                      },
                      text: S.of(context).checkout,
                      isArrowRight: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<ProductModel> cartDataToProductModel(List<HiveCartModel> list) {
    return list
        .map(
          (e) => ProductModel(
            id: e.id,
            name: e.name,
            currentPrice: e.price,
            imagePath: e.thumbnail,
            discountPercentage: e.discountPercentage,
            oldPrice: e.oldPrice,
          ),
        )
        .toList();
  }
}

class PricingInfo extends ConsumerWidget {
  const PricingInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? currency =
        ref.watch(appSettingDataProvider.notifier).state.currency;
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
        builder: (context, Box<HiveCartModel> box, child) {
          final totalPrice = box.values.isNotEmpty
              ? box.values
                  .map((e) => e.price * e.productsQTY)
                  .reduce((value, element) => value + element)
              : 0;
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Pricing Info",
                      style: AppTextStyle.normalBody.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                20.ph,
                for (var i in box.values.toList()) ...[
                  info(
                    title: i.name,
                    qty: "${i.productsQTY}X${i.price}",
                    price: "${i.price * i.productsQTY}",
                    currency: currency!,
                  ),
                  12.ph,
                ],
                const Divider(),
                info(
                  title: "Total Amount",
                  qty: "",
                  price: totalPrice.toStringAsFixed(2),
                  isTotal: true,
                  currency: currency!,
                ),
              ],
            ),
          );
        });
  }

  Row info({
    required String title,
    required String qty,
    required String price,
    bool isTotal = false,
    required String currency,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: AppTextStyle.normalBody.copyWith(
                  fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
                ),
              )),
              isTotal
                  ? const SizedBox()
                  : Expanded(
                      child: Text(
                        qty,
                        textAlign: TextAlign.right,
                        style: AppTextStyle.normalBody.copyWith(
                          color: const Color(0xff9CA3AF),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        20.pw,
        Text(
          "$currency$price",
          style: AppTextStyle.normalBody.copyWith(
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          ),
        )
      ],
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
