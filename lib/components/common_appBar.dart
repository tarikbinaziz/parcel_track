import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.isBackButtonVisible = true,
    this.child,
  });
  final String title;
  final bool isBackButtonVisible;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 134.h,
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.black : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: context.isDarkMode ? AppColor.black : AppColor.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            54.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      isBackButtonVisible
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back),
                            )
                          : const SizedBox.shrink(),
                      isBackButtonVisible ? 20.pw : 0.pw,
                      Text(
                        title,
                        style: AppTextStyle.normalBody
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                child ?? const SizedBox.shrink(),
              ],
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
