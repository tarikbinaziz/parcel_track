import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/store_model/store_model.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/views/dashboard/nearby_store/components/about_tab.dart';
import 'package:parcel_track/views/dashboard/nearby_store/components/review_tab.dart';
import 'package:parcel_track/views/dashboard/nearby_store/components/services_tab.dart';

class ShopServices extends ConsumerStatefulWidget {
  const ShopServices({super.key, required this.storeModel});
  final StoreModel storeModel;

  @override
  ConsumerState<ShopServices> createState() => _ShopServicesState();
}

class _ShopServicesState extends ConsumerState<ShopServices>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: context.isDarkMode
                ? AppColor.greyBackgroundColor
                : Colors.black,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 10),
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0.r,
              ),
              color: AppColor.primaryColor,
            ),
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: S.of(context).services,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: S.of(context).abt,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: S.of(context).reviews,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Container(
                color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
                child: ServiceTab(
                  storeId: widget.storeModel.id ?? 0,
                ),
              ),
              Container(
                color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
                child: AboutTab(
                  storeModel: widget.storeModel,
                ),
              ),
              Container(
                color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
                child: ReviewTab(
                  storeId: widget.storeModel.id ?? 0,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
