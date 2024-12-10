import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:pinput/pinput.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  late final TextEditingController pinController;
  late final GlobalKey<FormState> formKey;
  int time = 30;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    startTimmer();
  }

  void startTimmer() async {
    Timer.periodic(const Duration(seconds: 1), (val) {
      if (time >= 0) {
        setState(() {
          time > 0 ? time-- : time;
          time == 0 ? val.cancel() : val;
        });
      }
      if (time == 0) return;
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          children: [
            100.ph,
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/png/logo_black.png",
                width: 152.w,
                height: 80.h,
                fit: BoxFit.contain,
              ),
            ),
            80.ph,
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).phnvrfctn, // "Phone Verification"
                    style: AppTextStyle.title,
                  ),
                ),
                10.ph,
                Text(
                  "${S.of(context).entrotp} +8801725115085", // "Enter the 6 digit OTP Code that just we sent to your phone"
                  style: AppTextStyle.normalBody
                      .copyWith(color: const Color(0xFF6B7280)),
                ),
                20.ph,
                Pinput(
                  length: 6,
                  controller: pinController,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  preFilledWidget: Text(
                    "_",
                    style: AppTextStyle.normalBody.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        width: 22,
                        height: 1,
                        color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(30, 60, 87, 1),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.borderColor),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(30, 60, 87, 1),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(30, 60, 87, 1),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.borderColor),
                    ),
                  ),
                ),
                15.ph,
                time > 0
                    ? Row(
                        children: [
                          Text(
                            S.of(context).otpwillbesnd,
                          ), // "OTP will send within"
                          Text(
                            "00:${time.toString().padLeft(2, "0")}",
                            style: const TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(S.of(context).ndgtotp), // "Didn't receive OTP?"
                          InkWell(
                            onTap: () {
                              time = 30;
                              startTimmer();
                              setState(() {});
                            },
                            child: Text(
                              S.of(context).rsndotp,
                              style: const TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                20.ph,
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                      onPressed: () {
                        context.nav.pushNamed(Routes.dashboardScreen);
                      },
                      text: S.of(context).cnfrmotp), // "Confirm OTP"
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
