import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/dashboard/dashboard_controller.dart';
import 'package:parcel_track/models/others.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class ServiceTab extends ConsumerWidget {
  const ServiceTab({super.key, required this.storeId});
  final int storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      child: ref.watch(nearByStoreServiceProvider(storeId: storeId)).when(
            data: (list) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 160.r,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.nav.pushNamed(
                        Routes.productScreen,
                        arguments: ServiceArg(
                          serviceID: list[index].id ?? 0,
                          storeID: storeId,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16).r,
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColor.cardBlackBg
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
              return const Center(
                child: Text("Error"),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
