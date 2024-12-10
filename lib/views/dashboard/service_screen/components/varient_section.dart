import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/dashboard/dashboard_controller.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/models/others.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

// ignore: must_be_immutable
class VarientSection extends ConsumerWidget {
  const VarientSection({super.key, required this.arg});
  final ServiceArg arg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemList(),
          1.ph,
          // divider
          Container(
            height: 2,
            width: double.infinity,
            color: context.isDarkMode
                ? AppColor.black
                : AppColor.greyBackgroundColor,
          ),
        ],
      ),
    );
  }

  Widget _itemList() {
    return Consumer(
      builder: (context, ref, child) {
        final selectedVariant = ref.watch(selectedVarientIDProvider);
        final variantListNotifier = ref.watch(variantListProvider(arg));
        return variantListNotifier.when(
          data: (list) {
            return list.isEmpty
                ? const Center(
                    child: Text("No Product Available"),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10).r,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(list.length, (index) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(selectedVarientIDProvider.notifier)
                                    .state = list[index].id;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14).r,
                                margin:
                                    const EdgeInsets.only(right: 5, left: 5).r,
                                decoration: selectedVariant == list[index].id
                                    ? const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: AppColor.primaryColor,
                                              width: 2),
                                        ),
                                      )
                                    : null,
                                child: Text(
                                  list[index].name ?? '',
                                  style: selectedVariant == list[index].id
                                      ? AppTextStyle.smallBody.copyWith(
                                          color: AppColor.primaryColor,
                                          fontSize: 14.sp)
                                      : AppTextStyle.smallBody
                                          .copyWith(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
          },
          error: (error, stack) {
            return Center(
              child: Text(
                error.toString(),
                style: AppTextStyle.normalBody.copyWith(
                  color: AppColor.grayBlackBG,
                ),
              ),
            );
          },
          loading: () => const SizedBox(),
        );
      },
    );
  }
}
