import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/dashboard/dashboard_controller.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class ServiceSection extends ConsumerWidget {
  const ServiceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.black : Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                S.of(context).popularService,
                style: AppTextStyle.normalBody.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  ref.read(homeScreenIndexProvider.notifier).state = 1;
                },
                child: Text(
                  S.of(context).viewAll,
                  style: AppTextStyle.smallBody.copyWith(
                    color: AppColor.primaryColor,
                  ),
                ),
              )
            ],
          ),
          10.ph,
          Consumer(
            builder: (context, ref, child) {
              final serviceList = ref.watch(serviceListProvider);
              return serviceList.when(
                data: (list) {
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 160.r,
                    ),
                    itemCount: list.length >= 4 ? 4 : list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.nav.pushNamed(
                            Routes.serviceBasedStores,
                            arguments: list[index].id,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16).r,
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? AppColor.grayBlackBG
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColor.borderColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 45.r,
                                backgroundImage: CachedNetworkImageProvider(
                                  list[index].imagePath ?? "",
                                ),
                              ),
                              10.ph,
                              Text(
                                list[index].name ?? "",
                                style: AppTextStyle.normalBody.copyWith(
                                  fontSize: 14.sp,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (e, s) {
                  return Text("Error: $e");
                },
                loading: () => const SizedBox(),
              );
            },
          )
        ],
      ),
    );
  }
}
