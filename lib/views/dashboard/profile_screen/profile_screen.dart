import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/config/theme.dart';
import 'package:parcel_track/controllers/auth/auth_controller.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/cart_models/hive_cart_model.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      body: SingleChildScrollView(
        child: AnimationLimiter(
            child: Column(
                children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            _profileHeader(context),
            24.ph,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  OthersButton(
                    iconPath: Icons.payment,
                    title: "Payments",
                    onTap: () {
                      context.nav.pushNamed(Routes.paymentListScreen);
                    },
                  ),
                  16.ph,
                  OthersButton(
                    iconPath: Icons.history,
                    title: "Delivery History",
                    onTap: () {
                      context.nav
                          .pushNamed(Routes.historyScreen, arguments: true);
                    },
                  ),
                  16.ph,
                  OthersButton(
                    iconPath: Icons.read_more,
                    title: S.of(context).termsAndConditions,
                    onTap: () {
                      context.nav.pushNamed(Routes.othersScreen,
                          arguments: "Terms & Conditions");
                    },
                  ),
                  16.ph,
                  OthersButton(
                    iconPath: Icons.security,
                    title: S.of(context).privacyPolicy,
                    onTap: () {
                      context.nav.pushNamed(Routes.othersScreen,
                          arguments: "Privacy Policy");
                    },
                  ),
                  16.ph,
                  OthersButton(
                    iconPath: Icons.info_outline,
                    title: S.of(context).aboutUs,
                    onTap: () {
                      context.nav.pushNamed(Routes.othersScreen,
                          arguments: "About Us");
                    },
                  ),
                  32.ph,
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        logoutpopup(context);
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r))),
                        side: WidgetStateProperty.all(
                            const BorderSide(color: AppColor.primaryColor)),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 16.r, vertical: 12.r)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: AppColor.primaryColor,
                          ),
                          16.pw,
                          Text(
                            S.of(context).logout,
                            style: AppTextStyle.normalBody
                                .copyWith(color: AppColor.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ))),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppConstants.authBox).listenable(),
      builder: (context, Box authBox, child) {
        return Container(
          height: 165.h,
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          decoration: BoxDecoration(
            color: context.isDarkMode ? AppColor.black : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            // bottom box shadow
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withOpacity(0.1),
                offset: const Offset(0.0, 4.0),
                blurRadius: 16.0.r,
              ),
            ],
          ),
          child: authBox.get(AppConstants.authToken) != null
              ? InkWell(
                  onTap: () {
                    context.nav.pushNamed(Routes.profileScreen);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 75.r,
                        width: 75.r,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: authBox.get(AppConstants.userData)?[
                                  'profile_photo_path'] ??
                              "https://laundrymart.razinsoft.com/images/dummy/dummy-user.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      16.pw,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authBox.get(AppConstants.userData)?['name'] ?? "",
                            style: AppTextStyle.normalBody.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          6.ph,
                          Text(
                            authBox.get(AppConstants.userData)?['mobile'] ?? "",
                            style: AppTextStyle.normalBody.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.r,
                      )
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        30.ph,
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.cardLightBg,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 30.h,
                            ),
                          ),
                        ),
                        8.pw,
                        Row(
                          children: [
                            Text(
                              "Dev Tarik Bin Aziz",
                              style: AppTextStyle.title.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            // GestureDetector(
                            //   onTap: () {
                            //     context.nav.pushNamed(Routes.login);
                            //   },
                            //   child: Text(S.of(context).login,
                            //       style: AppTextStyle.title.copyWith(
                            //         fontSize: 14.sp,
                            //         color: AppColor.primaryColor,
                            //       )),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  logoutpopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 200.h,
                width: 335.w,
                padding: EdgeInsets.all(20.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).urabttolgot,
                        style: AppTextStyle.normalBody.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      10.ph,
                      Text(
                        S.of(context).arusre,
                        style: AppTextStyle.normalBody,
                        textAlign: TextAlign.center,
                      ),
                      20.ph,
                      SizedBox(
                        height: 50.h,
                        width: 335.w,
                        child: Row(children: [
                          Expanded(
                            child: CustomButton(
                              buttonColor:
                                  const Color.fromARGB(255, 255, 20, 3),
                              text: S.of(context).no,
                              onPressed: () {
                                context.nav.pop();
                              },
                            ),
                          ),
                          10.pw,
                          Expanded(
                              child: CustomButton(
                                  text: S.of(context).y,
                                  onPressed: () {
                                    context.nav.pop();
                                    // ignore: use_build_context_synchronously
                                    context.nav.pushNamed(
                                      Routes.login,
                                    );
                                  })),
                        ]),
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  deleteACpopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          final isLoading = ref.watch(logoutProvider);
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 200.h,
                width: 335.w,
                padding: EdgeInsets.all(20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).deleteAccount,
                      style: AppTextStyle.normalBody.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    10.ph,
                    Text(
                      S.of(context).arusre,
                      style: AppTextStyle.normalBody,
                      textAlign: TextAlign.center,
                    ),
                    20.ph,
                    SizedBox(
                      height: 50.h,
                      width: 335.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonColor:
                                  const Color.fromARGB(255, 255, 20, 3),
                              text: S.of(context).no,
                              onPressed: () {
                                context.nav.pop();
                              },
                            ),
                          ),
                          10.pw,
                          Expanded(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    text: S.of(context).y,
                                    onPressed: () {
                                      ref
                                          .read(logoutProvider.notifier)
                                          .logout()
                                          .then((value) async {
                                        if (value == true) {
                                          Hive.box(AppConstants.authBox)
                                              .clear();

                                          if (Hive.isBoxOpen(
                                              AppConstants.cartBox)) {
                                            await Hive.box<HiveCartModel>(
                                                    AppConstants.cartBox)
                                                .close();
                                          }
                                          await Hive.openBox<HiveCartModel>(
                                              AppConstants.cartBox);
                                          await Hive.box<HiveCartModel>(
                                                  AppConstants.cartBox)
                                              .clear();
                                          ref.invalidate(
                                              homeScreenIndexProvider);
                                          // ignore: use_build_context_synchronously
                                          context.nav.pop();
                                          // ignore: use_build_context_synchronously
                                          context.nav.pushNamed(
                                            Routes.login,
                                          );
                                        }
                                      });
                                    },
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LocaLizationSelector extends StatefulWidget {
  const LocaLizationSelector({super.key});

  @override
  State<LocaLizationSelector> createState() => _LocaLizationSelectorState();
}

class _LocaLizationSelectorState extends State<LocaLizationSelector> {
  final List<AppLanguage> languages = [
    AppLanguage(name: '\ud83c\uddfa\ud83c\uddf8 ENG', value: 'en'),
    AppLanguage(name: '🇪🇬 مصر', value: 'ar'),
    AppLanguage(name: '🇹🇷 Tür', value: 'tr'),
    AppLanguage(name: '🇧🇩 বাংলা', value: 'bn'),
  ];

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      decoration: AppTheme.inputDecoration.copyWith(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      initialValue: Hive.box(AppConstants.appSettingsBox)
          .get(AppConstants.appLocal) as String?,
      name: 'language',
      items: languages
          .map(
            (e) => DropdownMenuItem(
              value: e.value,
              child: Text(
                e.name,
                style: AppTextStyle.normalBody.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null && value != '') {
          Hive.box(AppConstants.appSettingsBox)
              .put(AppConstants.appLocal, value);
        }
      },
    );
  }
}

class AppLanguage {
  String name;
  String value;
  AppLanguage({
    required this.name,
    required this.value,
  });
}

Future setTheme({required bool value}) async {
  final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
  appSettingsBox.put(AppConstants.isDarkTheme, value);
}

class OthersButton extends StatelessWidget {
  const OthersButton({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  final IconData iconPath;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColor.cardBlackBg
              : AppColor.greyBackgroundColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).r,
            child: Row(
              children: [
                Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    iconPath,
                  ),
                ),
                16.pw,
                Text(
                  title,
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
