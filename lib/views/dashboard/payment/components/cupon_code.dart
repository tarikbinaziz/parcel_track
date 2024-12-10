import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/controllers/cart_controller/cart_controller.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/controllers/orders/orders_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class CuponCodeSection extends ConsumerStatefulWidget {
  const CuponCodeSection({super.key});

  @override
  ConsumerState<CuponCodeSection> createState() => _CuponCodeSectionState();
}

class _CuponCodeSectionState extends ConsumerState<CuponCodeSection> {
  late TextEditingController _couponController;

  @override
  void initState() {
    super.initState();
    _couponController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(applyCouponProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: CustomPaint(
              painter: DottedBorderPainter(
                color: AppColor.primaryColor,
                strokeWidth: 2.0,
                dashWidth: 5.0,
                dashSpace: 3.0,
              ),
              child: TextField(
                controller: _couponController,
                decoration: InputDecoration(
                  hintText: S.of(context).enterCouponCode,
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0).r,
                    child: SvgPicture.asset(
                      "assets/svgs/code_icon.svg",
                      colorFilter: const ColorFilter.mode(
                        AppColor.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          10.pw,
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: context.isDarkMode
                        ? AppColor.grayBlackBG
                        : AppColor.whiteColor,
                    minimumSize: Size(100.w, 46.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(
                        color:
                            ref.watch(cartController).cuponDiscountedAmount > 0
                                ? Colors.red
                                : AppColor.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onPressed: () {
                    final appSettingsBox =
                        Hive.box(AppConstants.appSettingsBox);
                    if (ref.read(cartController).cuponDiscountedAmount > 0) {
                      _couponController.clear();
                      ref.read(cartController.notifier).setCuponDiscount(0);
                      ref.invalidate(couponIdProvider);
                    } else {
                      if (_couponController.text.isNotEmpty) {
                        ref
                            .read(applyCouponProvider.notifier)
                            .applyCoupon(
                              couponCode: _couponController.text.trim(),
                              amount: ref.read(cartController).payableAmount,
                              storeId: appSettingsBox.get(AppConstants.storeId),
                            )
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Coupon applied successfully",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Coupon code is invalid",
                                ),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter coupon code",
                              ),
                            ),
                          );
                      }
                    }
                  },
                  child: Text(
                    ref.watch(cartController).cuponDiscountedAmount > 0
                        ? S.of(context).cancel
                        : S.of(context).apply,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ref.watch(cartController).cuponDiscountedAmount > 0
                          ? Colors.red
                          : AppColor.primaryColor,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DottedBorderPainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = Path();
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final segment = pathMetric.extractPath(distance, distance + dashWidth);
        dashPath.addPath(segment, Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
