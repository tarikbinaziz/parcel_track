import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/controllers/dashboard/dashboard_controller.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class BannerSection extends ConsumerWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(allPromotionProvider).when(
          data: (promo) {
            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: promo?.data?.promotions?.length ?? 0,
                  options: CarouselOptions(
                      height: 132.h,
                      autoPlay: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 300),
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        ref.read(journeyStepProvider.notifier).update((state) {
                          return index;
                        });
                      },
                      enableInfiniteScroll: false,
                      scrollPhysics: const BouncingScrollPhysics()),
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: SizedBox(
                        height: 120.h,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(12)),
                              child: CachedNetworkImage(
                                imageUrl:
                                    promo?.data?.promotions?[index].imagePath ??
                                        '',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                              // child: FlutterLogo(
                              //   size: 100,
                              // ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    promo?.data?.promotions?.length ?? 0,
                    (index) => _AnimatedDot(index: index),
                  ),
                ),
              ],
            );
          },
          error: (error, _) {
            return Center(
              child: Text("Error $error"),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}

class _AnimatedDot extends ConsumerWidget {
  const _AnimatedDot({required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(journeyStepProvider);
    final isActive = activeIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: AnimatedContainer(
        height: 6.h,
        width: 6,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInCirc,
        decoration: BoxDecoration(
          color: isActive
              ? AppColor.primaryColor
              : const Color(0xff39D8D8).withOpacity(0.25),
          borderRadius: BorderRadius.circular(5.h),
        ),
      ),
    );
  }
}
