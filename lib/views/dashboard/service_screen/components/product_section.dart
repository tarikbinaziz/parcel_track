import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/dashboard/dashboard_controller.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/views/cart/product_cart.dart';

class ProductSection extends ConsumerWidget {
  const ProductSection({super.key, required this.serviceID});
  final int serviceID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(selectedVarientIDProvider) == null
        ? const SizedBox()
        // ? const CircularProgressIndicator()
        : Expanded(
            child: ref
                .watch(productListProvider(
                    serviceID: serviceID,
                    variantID: ref.watch(selectedVarientIDProvider) ?? 0))
                .when(
                  data: (productList) {
                    return productList.isEmpty
                        ? const Center(
                            child: Text("No Item Found"),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              return ProductCart(
                                productModel: productList[index],
                              );
                            },
                          );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text(
                      stack.toString(),
                      style: AppTextStyle.normalBody.copyWith(
                        color: AppColor.grayBlackBG,
                      ),
                    ),
                  ),
                ),
          );
  }
}
