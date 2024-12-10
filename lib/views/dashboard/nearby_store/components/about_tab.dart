import 'dart:io';
import 'package:url_launcher/url_launcher.dart' as urlauncher;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/store_model/store_model.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/views/dashboard/nearby_store/components/map_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutTab extends ConsumerStatefulWidget {
  const AboutTab({super.key, required this.storeModel});

  final StoreModel storeModel;

  @override
  ConsumerState<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends ConsumerState<AboutTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).abt,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            10.ph,
            Text(
              widget.storeModel.description ?? "",
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            20.ph,
            // location
            Text(
              S.of(context).location,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.ph,
            Container(
              height: 180.h,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: MapView(
                latitude:
                    double.tryParse(widget.storeModel.latitude ?? '0.0') ?? 0,
                longitude:
                    double.tryParse(widget.storeModel.longitude ?? '0.0') ?? 0,
                shopName: widget.storeModel.name ?? '',
              ),
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Map Location",
                        style: AppTextStyle.normalBody
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: launchDirections,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        color: AppColor.primaryColor,
                      ),
                    ),
                    backgroundColor: context.isDarkMode
                        ? AppColor.cardBlackBg
                        : Colors.white,
                    foregroundColor: AppColor.primaryColor,
                    minimumSize: const Size(100, 35),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/arrow_icon.svg",
                        colorFilter: const ColorFilter.mode(
                          AppColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      5.pw,
                      Text(
                        S.of(context).getDirection,
                        style: AppTextStyle.smallBody,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void launchDirections() async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${widget.storeModel.latitude},${widget.storeModel.longitude}';
    final String appleMapUrl =
        'https://maps.apple.com/?daddr=${widget.storeModel.latitude},${widget.storeModel.longitude}';
    if (Platform.isIOS) {
      urlauncher.launchUrl(Uri.parse(appleMapUrl),
          mode: LaunchMode.externalNonBrowserApplication);
    } else if (Platform.isAndroid) {
      urlauncher.launchUrl(Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      throw 'Unsupported platform';
    }
  }
}
