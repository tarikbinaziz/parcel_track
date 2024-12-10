import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/dashboard/dashboard_controller.dart';
import 'package:parcel_track/controllers/others_controller/others_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/others.dart';
import 'package:parcel_track/models/store_model/store_model.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class ServiceBasedStores extends ConsumerWidget {
  const ServiceBasedStores({super.key, required this.serviceID});
  final int serviceID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(title: S.of(context).stores),
          ref.watch(serviceBasedStoresProvider(serviceID)).when(
                data: (storeList) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12).r,
                      itemCount: storeList.length,
                      itemBuilder: (context, index) {
                        return NearByStoreContainer(
                          store: storeList[index],
                          ontap: () {
                            // Call api to get order conditions
                            ref
                                .read(orderConditionProvider.notifier)
                                .getOrderConditions(
                                  storeId: storeList[index].id ?? 0,
                                );
                            // Store store id
                            // ref.read(storeIdProvider.notifier).state =
                            //     storeList[index].id ?? 0;
                            Box appSettingsBox =
                                Hive.box(AppConstants.appSettingsBox);
                            appSettingsBox.put(
                              AppConstants.storeId,
                              storeList[index].id,
                            );
                            // Navigate to product screen
                            context.nav.pushNamed(
                              Routes.productScreen,
                              arguments: ServiceArg(
                                serviceID: serviceID,
                                storeID: storeList[index].id ?? 0,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    error.toString(),
                    style: AppTextStyle.normalBody.copyWith(
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class NearByStoreContainer extends StatelessWidget {
  const NearByStoreContainer({
    super.key,
    this.ontap,
    this.width,
    this.height,
    this.margin,
    this.imagewidth,
    this.imageheight,
    required this.store,
  });
  final Function()? ontap;
  final double? width;
  final double? height;
  final double? margin;
  final double? imagewidth;
  final double? imageheight;
  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(top: margin ?? 8.h),
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 96.h,
        decoration: BoxDecoration(
            color:
                context.isDarkMode ? AppColor.cardBlackBg : AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            children: [
              12.ph,
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8).r,
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: store.logo ??
                          "https://laundrymart.razinsoft.com/images/dummy/dummy-user.png",
                      fit: BoxFit.cover,
                      width: imagewidth ?? 72.w,
                      height: imageheight ?? 72.h,
                    ),
                  ),
                  8.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              store.name ?? "",
                              style: AppTextStyle.normalBody.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              width: 32.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: store.owner!.isActive == true
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  store.owner!.isActive == true
                                      ? "Open"
                                      : "Close",
                                  style: AppTextStyle.extraLargeBody.copyWith(
                                    color: AppColor.whiteColor,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        6.ph,
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_sharp,
                              color: Colors.blue,
                              size: 20,
                            ),
                            4.pw,
                            Expanded(
                              child: Text(
                                store.address != null
                                    ? store.address!.addressName!
                                    : "",
                                style: AppTextStyle.normalBody,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        6.ph,
                        Row(
                          children: [
                            Text(
                              store.distance ?? "",
                              style: AppTextStyle.normalBody
                                  .copyWith(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 14.h,
                              child: const VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("assets/svgs/rating_icon.svg"),
                                5.45.ph,
                                Text(
                                  store.averageRating ?? "",
                                  style: AppTextStyle.normalBody,
                                ),
                                5.45.ph,
                                Text(
                                  "(${store.totalRating ?? ""})",
                                  style: AppTextStyle.normalBody.copyWith(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
