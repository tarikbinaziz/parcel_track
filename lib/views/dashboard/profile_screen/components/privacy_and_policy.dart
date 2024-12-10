import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/controllers/others_controller/others_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/utils/extensions.dart';

class PrivacyAndPolicy extends ConsumerWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(title: S.of(context).privacyPolicyTitle),
          10.ph,
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
                child: ref.watch(privacyAndPolicyProvider).when(
                      data: (termsAndCondition) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10)
                              .r,
                          child: Text(
                            parse(termsAndCondition.data?.setting?.content ??
                                    S.of(context).contentUnavailable)
                                .documentElement!
                                .text,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(
                        child: Text(
                          S.of(context).errorText(error.toString()),
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
