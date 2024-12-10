import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/misc/enums.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class NotificationFilterList extends ConsumerWidget {
  const NotificationFilterList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNotificationType =
        ref.watch(selectedNotificationTypeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(NotificationType.values.length, (index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      ref
                          .read(selectedNotificationTypeProvider.notifier)
                          .state = NotificationType.values[index];
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)
                          .r,
                      decoration: BoxDecoration(
                        color: selectedNotificationType ==
                                NotificationType.values[index]
                            ? AppColor.whiteColor
                            : AppColor.greyBackgroundColor,
                        borderRadius: BorderRadius.circular(40.r),
                        border: selectedNotificationType ==
                                NotificationType.values[index]
                            ? Border.all(color: AppColor.primaryColor)
                            : null,
                      ),
                      child: Text(
                        NotificationType.values[index]
                            .toString()
                            .split('.')
                            .last
                            .replaceFirst(
                              NotificationType.values[index]
                                  .toString()
                                  .split('.')
                                  .last
                                  .substring(0, 1),
                              NotificationType.values[index]
                                  .toString()
                                  .split('.')
                                  .last
                                  .substring(0, 1)
                                  .toUpperCase(),
                            ),
                        style: AppTextStyle.normalBody.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: selectedNotificationType ==
                                  NotificationType.values[index]
                              ? AppColor.primaryColor
                              : const Color(0xff334155),
                        ),
                      ),
                    ),
                  ),
                  10.pw,
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
