import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/config/theme.dart';
import 'package:parcel_track/controllers/auth/auth_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: FormBuilder(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  40.ph,
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      Theme.of(context).scaffoldBackgroundColor ==
                              AppColor.grayBlackBG
                          ? "assets/images/png/logo_black.png"
                          : "assets/images/png/logo_black.png",
                      width: 152.w,
                      height: 90.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // 8.ph,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 250.w,
                      height: 50.h,
                    ),
                  ),

                  Text(
                    S.of(context).eztogetservice,
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff6B7280),
                    ),
                  ),
                  8.ph,
                  Text(
                    S.of(context).enterphone, // Updated to use localization key
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  32.ph,
                  FormBuilderTextField(
                    name: 'phone',
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                    style: AppTextStyle.normalBody,
                    decoration: AppTheme.inputDecoration
                        .copyWith(labelText: S.of(context).phnn),
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(6,
                          errorText: S.of(context).entravalidphnnmbr),
                      FormBuilderValidators.maxLength(12,
                          errorText: S.of(context).entravalidphnnmbr),
                      FormBuilderValidators.required()
                    ]),
                  ),
                  20.ph,
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: obsecureText,
                    style: AppTextStyle.normalBody,
                    decoration: AppTheme.inputDecoration.copyWith(
                      labelText: S.of(context).password,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obsecureText = !obsecureText;
                          });
                        },
                        child: Icon(
                          obsecureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: AppColor.grayBlackBG,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                  ),
                  10.ph,
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       S.of(context).forgotPassword,
                  //       style: AppTextStyle.normalBody.copyWith(
                  //         fontSize: 14.sp,
                  //         color: AppColor.primaryColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  40.ph,
                  Consumer(
                    builder: (context, ref, child) {
                      final loginLoading = ref.watch(loginProvider);
                      return loginLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              onPressed: () {
                                context.nav.pushNamed(Routes.dashboardScreen);
                              },
                              text: S.of(context).prcdnxt,
                              isArrowRight: true,
                            );
                    },
                  ),
                  35.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).dontHaveAccount,
                        style: AppTextStyle.normalBody.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      4.pw,
                      GestureDetector(
                        onTap: () {
                          context.nav.pushNamed(Routes.signUp);
                        },
                        child: Text(
                          S
                              .of(context)
                              .signUp, // Updated to use localization key
                          style: AppTextStyle.normalBody.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
