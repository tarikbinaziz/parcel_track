import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/dashboard/dashboard_controller.dart';
import 'package:laundrymart_flutter/controllers/others_controller/others_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/cart_models/hive_cart_model.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';
import 'package:laundrymart_flutter/views/dashboard/home_screen/components/home_appBar.dart';
import 'package:laundrymart_flutter/views/dashboard/service_screen/components/service_based_stores.dart';

class NearbyStoreScreen extends ConsumerWidget {
  const NearbyStoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          NearByStoreAppbar(
            controller: TextEditingController(),
            ontap: () {},
          ),
          Expanded(
            child: ref.watch(nearByStoresProvider).when(
              data: (storeList) {
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: storeList.length,
                  itemBuilder: (context, index) {
                    return NearByStoreContainer(
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

                        // Navigate to service screen
                        context.nav.pushNamed(
                          Routes.storeDetails,
                          // arguments: StoreArg(
                          //   storeID: storeList[index].id,
                          //   storeModel: storeList[index],
                          // ),
                          arguments: storeList[index],
                        );
                      },
                      store: storeList[index],
                    );
                  },
                );
              },
              error: (error, stack) {
                return Center(
                  child: Text(
                    error.toString(),
                    style: AppTextStyle.normalBody,
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class NearByStoreAppbar extends ConsumerStatefulWidget {
  const NearByStoreAppbar({
    super.key,
    this.ontap,
    required TextEditingController controller,
  }) : _controller = controller;
  final Function()? ontap;
  final TextEditingController _controller;

  @override
  ConsumerState<NearByStoreAppbar> createState() => _NearByStoreAppbarState();
}

class _NearByStoreAppbarState extends ConsumerState<NearByStoreAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 134.h,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.black : Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            44.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 280.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.greyBackgroundColor.withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget._controller,
                          style: AppTextStyle.normalBody,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).searchstore,
                            hintStyle: AppTextStyle.normalBody
                                .copyWith(color: Colors.grey),
                            contentPadding: EdgeInsets.only(
                              left: 15.w,
                              right: 0.w,
                              bottom: 8.w,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.ontap?.call();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 15.w,
                            left: 0.w,
                          ),
                          child: SvgPicture.asset(
                            "assets/svgs/search_icon.svg",
                            fit: BoxFit.cover,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.pw,
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
          ],
        ),
      ),
    );
  }
}
