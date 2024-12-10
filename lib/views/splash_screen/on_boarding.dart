import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends ConsumerWidget {
  OnBoardingScreen({super.key});
  bool shouldAnimate = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(onBoardingSliderIndexProvider);
    final imgPageController =
        ref.watch(onBoardingSliderControllerProvider('image'));
    shouldAnimate = true;
    return Padding(
      padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  Theme.of(context).scaffoldBackgroundColor ==
                          AppColor.grayBlackBG
                      ? "assets/images/png/logo_white.png"
                      : "assets/images/png/logo_black.png",
                  height: 120.h,
                ),
              ),
              AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: shouldAnimate ? 1 : 0,
                child: const OnBoadringImageSlider(),
              ),
              20.ph,
              SizedBox(
                width: 335.w,
                height: 6.h,
                child: CustomJourneyDot(activeIndex: index, count: 3),
              ),
              20.ph,
              const OnBoadringTextSlider(),
              20.ph,
              CustomButton(
                text: S.of(context).letsGetStarted,
                onPressed: () {
                  if (index < 2) {
                    ref
                        .watch(onBoardingSliderIndexProvider.notifier)
                        .update((state) {
                      imgPageController.animateToPage(
                        state + 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                      return state + 1;
                    });
                  } else {
                    final Box appSettingsBox =
                        Hive.box(AppConstants.appSettingsBox);
                    appSettingsBox.put(AppConstants.hasSeenSplashScreen, true);
                    context.nav.pushNamedAndRemoveUntil(
                      Routes.dashboardScreen,
                      (route) => false,
                    );
                  }
                },
              )
            ],
          ),
          if (index < 2)
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  final Box appSettingsBox =
                      Hive.box(AppConstants.appSettingsBox);
                  appSettingsBox.put(AppConstants.hasSeenSplashScreen, true);
                  context.nav.pushNamedAndRemoveUntil(
                    Routes.dashboardScreen,
                    (route) => false,
                  );
                },
                child: Container(
                  // height: 30.h,
                  // width: 70.w,
                  padding: EdgeInsets.only(left: 5.w),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).skip,
                        style: AppTextStyle.normalBody.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      const Icon(
                        Icons.arrow_right,
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
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
