import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/cart_controller/cart_repo.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/cart_models/hive_cart_model.dart';
import 'package:laundrymart_flutter/models/product_model/product_model.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class ProductCart extends ConsumerWidget {
  const ProductCart({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currency =
        ref.watch(appSettingDataProvider.notifier).state.currency;
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<HiveCartModel>(AppConstants.cartBox).listenable(),
        builder: (context, Box<HiveCartModel> box, child) {
          bool inCart = false;
          late int productQuantity;
          late int index;
          final cartItems = box.values.toList();
          for (int i = 0; i < cartItems.length; i++) {
            final cartProduct = cartItems[i];
            if (cartProduct.id == productModel.id) {
              inCart = true;
              productQuantity = cartProduct.productsQTY;
              index = i;
              break;
            }
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: context.isDarkMode
                        ? AppColor.cardBlackBg
                        : AppColor.greyBackgroundColor,
                    width: 1),
              ),
              color: context.isDarkMode ? AppColor.cardBlackBg : Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 60.r,
                        height: 60.r,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: productModel.imagePath ?? '',
                        ),
                      ),
                      12.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productModel.service?.name ?? '',
                              style: AppTextStyle.smallBody.copyWith(
                                fontSize: 10.sp,
                                color: context.isDarkMode
                                    ? AppColor.black
                                    : const Color(0xff9CA3AF),
                              ),
                            ),
                            2.ph,
                            Text(
                              productModel.name ?? '',
                              style: AppTextStyle.normalBody.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            4.ph,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Old Price
                                Text(
                                  productModel.oldPrice != null
                                      ? "$currency${productModel.oldPrice}"
                                      : "",
                                  style: AppTextStyle.largeBody.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff9CA3AF),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                5.pw,
                                // Current Price
                                Text(
                                  "$currency${productModel.currentPrice}",
                                  style: AppTextStyle.largeBody.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                5.pw,
                                Text(
                                  S.of(context).item,
                                  style: AppTextStyle.largeBody.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                5.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(3).r,
                      child: Text(
                        "%${productModel.discountPercentage ?? 0} ${S.of(context).off}",
                        style: AppTextStyle.smallBody.copyWith(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    10.ph,
                    inCart
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  ref.read(cartRepo).decrementProductQuantity(
                                        productId: productModel.id!,
                                        cartBox: box,
                                        index: index,
                                      );
                                },
                                child: Container(
                                  width: 28.r,
                                  height: 28.r,
                                  decoration: const BoxDecoration(
                                    color: AppColor.greyBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: context.isDarkMode
                                        ? AppColor.greyBackgroundColor
                                        : AppColor.black,
                                  ),
                                ),
                              ),
                              8.pw,
                              Text(
                                productQuantity.toString(),
                                style: AppTextStyle.normalBody
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              8.pw,
                              InkWell(
                                onTap: () {
                                  ref.read(cartRepo).incrementProductQuantity(
                                        productId: productModel.id!,
                                        box: box,
                                        index: index,
                                      );
                                },
                                child: Container(
                                  width: 28.r,
                                  height: 28.r,
                                  decoration: const BoxDecoration(
                                    color: AppColor.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: context.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            onTap: () async {
                              final cartBox =
                                  Hive.box<HiveCartModel>(AppConstants.cartBox);

                              HiveCartModel cartModel = HiveCartModel(
                                id: productModel.id!,
                                name: productModel.name!,
                                thumbnail: productModel.imagePath!,
                                price: productModel.currentPrice!,
                                productsQTY: 1,
                                discountPercentage:
                                    productModel.discountPercentage ?? 0,
                                oldPrice: productModel.oldPrice ?? 0,
                              );

                              await cartBox.add(cartModel);
                            },
                            child: Container(
                              width: 28.r,
                              height: 28.r,
                              decoration: const BoxDecoration(
                                color: AppColor.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: context.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
