import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/config/theme.dart';
import 'package:laundrymart_flutter/controllers/auth/auth_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

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
        body: FormBuilder(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                44.ph,
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Theme.of(context).scaffoldBackgroundColor ==
                            AppColor.grayBlackBG
                        ? "assets/images/png/logo_white.png"
                        : "assets/images/png/logo_black.png",
                    width: 152.w,
                    height: 80.h,
                    fit: BoxFit.contain,
                  ),
                ),
                8.ph,
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/svgs/login_asset.svg",
                    height: 123.h,
                    width: 123.w,
                  ),
                ),
                8.ph,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).forgotPassword,
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                32.ph,
                Consumer(
                  builder: (context, ref, child) {
                    final loginLoading = ref.watch(loginProvider);
                    return loginLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            onPressed: () {
                              if (_formkey.currentState!.saveAndValidate()) {
                                final formData = _formkey.currentState!.value;

                                ref
                                    .read(loginProvider.notifier)
                                    .login(
                                      phone: formData['phone'],
                                      password: formData['password'],
                                    )
                                    .then((value) async {
                                  if (value == true) {
                                    context.nav
                                        .pushNamed(Routes.dashboardScreen);
                                  } else {
                                    ref.invalidate(loginProvider);
                                  }
                                });
                              }
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
                    GestureDetector(
                      onTap: () {
                        context.nav.pushNamed(Routes.signUp);
                      },
                      child: Text(
                        S.of(context).signUp, // Updated to use localization key
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
    );
  }
}
