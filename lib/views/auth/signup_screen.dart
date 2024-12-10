import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/config/theme.dart';
import 'package:laundrymart_flutter/controllers/auth/auth_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  bool obsecureText = true;
  bool obsecureTextTwo = true;
  bool shouldRemember = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: FormBuilder(
          key: _formkey,
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Column(
                  children: [
                    Center(
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          Theme.of(context).scaffoldBackgroundColor ==
                                  AppColor.grayBlackBG
                              ? "assets/images/png/logo_white.png"
                              : "assets/images/png/logo_black.png",
                          width: 152.w,
                          height: 80.h,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Column(
                            children: [
                              15.ph,
                              Center(
                                child: Image.asset(
                                  'assets/images/png/signup_asset.png',
                                  height: 145.h,
                                ),
                              ),
                              15.ph,
                              FormBuilderTextField(
                                name: 'first_name',
                                style: AppTextStyle.normalBody,
                                decoration: AppTheme.inputDecoration.copyWith(
                                  labelText: S.of(context).fullName,
                                  labelStyle: AppTextStyle.normalBody.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()],
                                ),
                              ),
                              20.ph,
                              FormBuilderTextField(
                                name: 'email',
                                style: AppTextStyle.normalBody,
                                decoration: AppTheme.inputDecoration.copyWith(
                                  labelText: S.of(context).emailOptional,
                                  labelStyle: AppTextStyle.normalBody.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: FormBuilderValidators.compose(
                                  [
                                    (value) {
                                      if (value != null && value.isNotEmpty) {
                                        return FormBuilderValidators.email()(
                                            value);
                                      }
                                      return null;
                                    },
                                  ],
                                ),
                              ),
                              20.ph,
                              FormBuilderTextField(
                                name: 'mobile',
                                style: AppTextStyle.normalBody,
                                decoration: AppTheme.inputDecoration.copyWith(
                                  isDense: true,
                                  labelText: S.of(context).phoneNumber,
                                  labelStyle: AppTextStyle.normalBody.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.minLength(6,
                                      errorText:
                                          S.of(context).entravalidphnnmbr),
                                  FormBuilderValidators.maxLength(12,
                                      errorText:
                                          S.of(context).entravalidphnnmbr),
                                  FormBuilderValidators.required()
                                ]),
                              ),
                              20.ph,
                              FormBuilderTextField(
                                name: 'password',
                                obscureText: obsecureText,
                                style: AppTextStyle.normalBody,
                                decoration: AppTheme.inputDecoration.copyWith(
                                  labelText: S.of(context).createPassword,
                                  labelStyle: AppTextStyle.normalBody.copyWith(
                                    color: Colors.grey,
                                  ),
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
                                textInputAction: TextInputAction.next,
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(6),
                                  ],
                                ),
                              ),
                              20.ph,
                              FormBuilderTextField(
                                name: 'password_confirmation',
                                obscureText: obsecureTextTwo,
                                style: AppTextStyle.normalBody,
                                decoration: AppTheme.inputDecoration.copyWith(
                                  labelText: S.of(context).confirmPassword,
                                  labelStyle: AppTextStyle.normalBody.copyWith(
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsecureTextTwo = !obsecureTextTwo;
                                      });
                                    },
                                    child: Icon(
                                      obsecureTextTwo
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility,
                                      color: AppColor.grayBlackBG,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(),
                                    // min length 6
                                    FormBuilderValidators.minLength(6),
                                    // check if password and confirm password are same
                                    (value) {
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          value !=
                                              _formkey.currentState!
                                                  .value['password']) {
                                        return "Password does not match";
                                      }
                                      return null;
                                    },
                                  ],
                                ),
                              ),
                              8.ph,
                              FormBuilderCheckbox(
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                                name: 'accept_terms',
                                initialValue: false,
                                activeColor: AppColor.primaryColor,
                                checkColor: Colors.white,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  isCollapsed: false,
                                ),
                                contentPadding: EdgeInsets.zero,
                                title: Wrap(
                                  children: [
                                    Text(
                                      S.of(context).iAgreeToThe,
                                      style: AppTextStyle.normalBody,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.nav.pushNamed(
                                            Routes.termsAndConditions);
                                      },
                                      child: Text(
                                        S.of(context).termsAndConditions,
                                        style: AppTextStyle.normalBody.copyWith(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()],
                                ),
                              ),
                              12.ph,
                              Consumer(
                                builder: (context, ref, child) {
                                  final isLoading = ref.watch(signUpProvider);
                                  return isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : SizedBox(
                                          width: double.infinity,
                                          child: CustomButton(
                                            onPressed: () {
                                              if (_formkey.currentState!
                                                      .saveAndValidate() &&
                                                  _formkey.currentState!.value[
                                                          'accept_terms'] ==
                                                      true) {
                                                final data = _formkey
                                                    .currentState!.value;
                                                ref
                                                    .read(
                                                        signUpProvider.notifier)
                                                    .signUp(data: data)
                                                    .then(
                                                  (value) {
                                                    if (value == true) {
                                                      context.nav.pushNamed(
                                                          Routes
                                                              .dashboardScreen);
                                                    } else {
                                                      ref.invalidate(
                                                          signUpProvider);
                                                    }
                                                  },
                                                );
                                              } else {
                                                EasyLoading.showError(
                                                    "Please accept terms and conditions");
                                              }
                                            },
                                            text: S.of(context).signUp,
                                          ),
                                        );
                                },
                              ),
                              12.ph,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).alreadyHaveAnAccount,
                                    style: AppTextStyle.normalBody,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.nav.pop();
                                    },
                                    child: Text(
                                      "${S.of(context).login} ${S.of(context).here}",
                                      style: AppTextStyle.normalBody.copyWith(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}