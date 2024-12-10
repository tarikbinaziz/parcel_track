import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/components/common_appBar.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/controllers/others_controller/others_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class AboutUs extends ConsumerWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(
              title: S.of(context).aboutUsTitle), // Use the localized string
          10.ph,
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
                width: double.infinity,
                child: ref.watch(aboutUsProvider).when(
                      data: (aboutUs) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10)
                              .r,
                          child: Column(
                            children: [
                              Text(
                                aboutUs.data?.title ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                              10.ph,
                              Text(
                                S.of(context).aboutUsPhone,
                                // Use the localized string
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(
                        child: Text(
                          error.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
