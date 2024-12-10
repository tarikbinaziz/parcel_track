import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_constants.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/config/theme.dart';
import 'package:laundrymart_flutter/controllers/auth/auth_controller.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/cart_models/hive_cart_model.dart';
import 'package:laundrymart_flutter/routes.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      body: ValueListenableBuilder(
          valueListenable: Hive.box(AppConstants.authBox).listenable(),
          builder: (context, Box authBox, child) {
            final isLoggedIn = authBox.get(AppConstants.authToken) != null;
            return Column(
              children: [
                _profileHeader(context),
                40.ph,
                switches(),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20)
                          .r,
                  child: Column(
                    children: [
                      isLoggedIn
                          ? OthersButton(
                              iconPath: "assets/svgs/map.svg",
                              title: S.of(context).manageAddress,
                              onTap: () {
                                context.nav.pushNamed(Routes.manageAddress);
                              },
                            )
                          : const SizedBox.shrink(),
                      16.ph,
                      OthersButton(
                        iconPath: "assets/svgs/message-text.svg",
                        title: S.of(context).termsAndConditions,
                        onTap: () {
                          context.nav.pushNamed(Routes.termsAndConditions);
                        },
                      ),
                      16.ph,
                      OthersButton(
                        iconPath: "assets/svgs/security-safe.svg",
                        title: S.of(context).privacyPolicy,
                        onTap: () {
                          context.nav.pushNamed(Routes.privacyPolicy);
                        },
                      ),
                      16.ph,
                      OthersButton(
                        iconPath: "assets/svgs/tabler_info-circle-filled.svg",
                        title: S.of(context).aboutUs,
                        onTap: () {
                          context.nav.pushNamed(Routes.aboutUs);
                        },
                      ),
                      25.ph,
                      isLoggedIn
                          ? SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  logoutpopup(context);
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.r))),
                                  side: WidgetStateProperty.all(
                                      const BorderSide(color: Colors.red)),
                                  padding: WidgetStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 16.r, vertical: 12.r)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ),
                                    16.pw,
                                    Text(
                                      S.of(context).logout,
                                      style: AppTextStyle.normalBody
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      25.ph,
                      isLoggedIn
                          ? SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  deleteACpopup(context);
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.r))),
                                  side: WidgetStateProperty.all(
                                      const BorderSide(color: Colors.red)),
                                  padding: WidgetStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 16.r, vertical: 12.r)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    16.pw,
                                    Text(
                                      S.of(context).deleteAccount,
                                      style: AppTextStyle.normalBody
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget switches() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: Hive.box(AppConstants.appSettingsBox).listenable(),
            builder: (context, box, _) {
              final bool isDarkTheme =
                  box.get(AppConstants.isDarkTheme, defaultValue: false);
              return AnimatedToggleSwitch<bool>.dual(
                current: isDarkTheme,
                first: false,
                second: true,
                onChanged: (value) {
                  setTheme(value: value);
                },
                styleBuilder: (b) => ToggleStyle(
                  indicatorColor:
                      b ? AppColor.primaryColor : AppColor.grayBlackBG,
                ),
                iconBuilder: (value) => value
                    ? const Icon(
                        Icons.light_mode,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.dark_mode,
                        color: Colors.white,
                      ),
                textBuilder: (value) => value
                    ? const Center(child: Text('Light'))
                    : const Center(child: Text('Dark')),
              );
            },
          ),
          SizedBox(
            width: 120.w,
            child: const LocaLizationSelector(),
          ),
        ],
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 75.r,
                      width: 75.r,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60.h,
                      ),
                    ),
                    16.pw,
                    Text(
                      S.of(context).login,
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        onPressed: () {
                          context.nav.pushNamed(Routes.login);
                        },
                        text: S.of(context).login,
                      ),
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

  final String iconPath;
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
                  child: SvgPicture.asset(
                    iconPath,
                    fit: BoxFit.cover,
                  ),
                ),
                16.pw,
                Text(
                  title,
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 16.sp,
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
