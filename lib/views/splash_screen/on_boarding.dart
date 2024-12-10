import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends ConsumerWidget {
  OnBoardingScreen({super.key});
  bool shouldAnimate = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.65), BlendMode.darken),
              fit: BoxFit.cover,
              image: const AssetImage("assets/images/png/Rectangle 1467.png"))),
      child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.ph,
            Center(
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  Theme.of(context).scaffoldBackgroundColor ==
                          AppColor.grayBlackBG
                      ? "assets/images/png/logo_black.png"
                      : "assets/images/png/logo_black.png",
                  height: 90.h,
                ),
              ),
            ),
            Expanded(child: 20.ph),
            Text(
              "Request for Delivery\nin few clicks",
              style: AppTextStyle.title
                  .copyWith(fontSize: 24.sp, color: Colors.white),
            ),
            20.ph,
            Text(
              "On-demand delivery whenever and\nwherever the need arises.",
              style: AppTextStyle.normalBody.copyWith(color: Colors.white),
            ),
            70.ph,
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                  text: S.of(context).letsGetStarted,
                  onPressed: () {
                    context.nav.pushNamedAndRemoveUntil(
                      Routes.login,
                      (route) => false,
                    );
                  }),
            ),
            120.ph,
          ],
        ),
      ),
    );
  }
}

class OnBoadringImageSlider extends StatelessWidget {
  const OnBoadringImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          height: 320.h,
          width: 250.w,
          child: PageView(
            controller: ref.watch(onBoardingSliderControllerProvider('image')),
            children: slideData(context)
                .map(
                  (e) => Image.asset(
                    e.image,
                  ),
                )
                .toList(),
            onPageChanged: (val) {
              ref
                  .watch(onBoardingSliderControllerProvider('text'))
                  .animateToPage(
                    val,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
              ref.watch(onBoardingSliderIndexProvider.notifier).state = val;
            },
          ),
        );
      },
    );
  }
}

class OnBoadringTextSlider extends StatelessWidget {
  const OnBoadringTextSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          height: 130.h,
          width: 335.w,
          child: PageView(
            controller: ref.watch(onBoardingSliderControllerProvider('text')),
            physics: const NeverScrollableScrollPhysics(),
            children: slideData(context)
                .map(
                  (e) => Text(e.text,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.normalBody
                          .copyWith(fontWeight: FontWeight.w700)
                      //  AppTextDecor.bold12Black.copyWith(
                      //   color: AppStaticColor.black,
                      //   fontSize: 16.sp,
                      // ),
                      ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class CustomJourneyDot extends StatelessWidget {
  const CustomJourneyDot({
    super.key,
    required this.activeIndex,
    required this.count,
  });
  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 6.h,
              width: activeIndex == index ? 36.w : 6.w,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(3.h),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<ObSliderData> slideData(context) => [
      ObSliderData(
        image: 'assets/images/png/img 1.png',
        text: S.of(context).orderOnlineViaApp,
      ),
      ObSliderData(
        image: 'assets/images/png/img 2.png',
        text: S.of(context).weCollectAtTime,
      ),
      ObSliderData(
        image: 'assets/images/png/img 3.png',
        text: S.of(context).weReturnCleanClothes,
      ),
    ];

class ObSliderData {
  String image;
  String text;
  ObSliderData({
    required this.image,
    required this.text,
  });
}
