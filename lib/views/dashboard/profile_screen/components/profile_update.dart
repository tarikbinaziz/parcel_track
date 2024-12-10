import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/config/theme.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/controllers/profile/profile_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/utils/extensions.dart';

class ProfileUpdateScreen extends ConsumerWidget {
  ProfileUpdateScreen({super.key});
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonAppBar(
              title: S.of(context).myProfileTitle,
            ),
            1.5.ph,
            const ProfileHeader(),
            10.ph,
            UserForm(formKey: _formKey),
          ],
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final isLoading = ref.watch(updateProfileProvider);
          return Container(
            height: 88.h,
            width: double.infinity,
            color: context.isDarkMode ? AppColor.black : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    onPressed: () async {
                      Map<String, dynamic> formData;
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (ref.read(pickProfileImgProvider) != null) {
                          formData = {
                            ..._formKey.currentState!.value,
                            'profile_photo': await MultipartFile.fromFile(
                                ref.read(pickProfileImgProvider)!.path),
                          };
                        } else {
                          formData = _formKey.currentState!.value;
                        }
                        ref
                            .read(updateProfileProvider.notifier)
                            .updateProfile(data: formData)
                            .then((value) {
                          if (value == true) {
                            EasyLoading.showSuccess(
                                S.of(context).profileUpdateSuccess);
                          } else {
                            EasyLoading.showError(
                                S.of(context).profileUpdateFailure);
                            ref.invalidate(updateProfileProvider);
                          }
                        });
                      }
                    },
                    text: S.of(context).updateButtonText,
                  ),
          );
        },
      ),
    );
  }
}

class UserForm extends StatelessWidget {
  const UserForm({super.key, required GlobalKey<FormBuilderState> formKey})
      : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppConstants.authBox).listenable(),
      builder: (context, Box box, child) {
        return FormBuilder(
          key: _formKey,
          initialValue: {
            'first_name': box.get(AppConstants.userData)?['name'] ?? "",
            'gender': box.get(AppConstants.userData)?['gender'] ?? "",
            'email': box.get(AppConstants.userData)?['email'] ?? "",
            'mobile': box.get(AppConstants.userData)?['mobile'] ?? "",
          },
          child: Container(
            width: double.infinity,
            color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            child: Column(
              children: [
                // name field
                FormBuilderTextField(
                  name: 'first_name',
                  decoration: AppTheme.inputDecoration.copyWith(
                    labelText: S.of(context).nameFieldLabel,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                25.ph,
                // gender dropdown
                FormBuilderDropdown(
                  name: "gender",
                  decoration: AppTheme.inputDecoration.copyWith(
                    labelText: S.of(context).genderFieldLabel,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  items: [
                    S.of(context).maleOption,
                    S.of(context).femaleOption,
                    S.of(context).otherOption
                  ]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                25.ph,
                // email field optional
                FormBuilderTextField(
                  name: 'email',
                  decoration: AppTheme.inputDecoration.copyWith(
                    labelText: S.of(context).emailFieldLabel,
                  ),
                ),
                25.ph,
                // phone field
                FormBuilderTextField(
                  name: 'mobile',
                  readOnly: true,
                  decoration: AppTheme.inputDecoration.copyWith(
                    labelText: S.of(context).phoneFieldLabel,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({
    super.key,
  });

  void pickedImage(WidgetRef ref) async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      ref.read(pickProfileImgProvider.notifier).update((value) => img);
    }
    return;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, Box box, child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 95.r,
                      width: 95.r,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: ref.watch(pickProfileImgProvider) != null
                          ? Image.file(
                              File(ref.watch(pickProfileImgProvider)!.path),
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: box.get(AppConstants.userData)?[
                                      'profile_photo_path'] ??
                                  "https://laundrymart.razinsoft.com/images/dummy/dummy-user.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 5,
                      child: InkWell(
                        onTap: () {
                          pickedImage(ref);
                        },
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: AppColor.primaryColor,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 17.r,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                12.ph,
                Text(
                  box.get(AppConstants.userData)?['name'] ?? "User Name",
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                4.ph,
                Text(
                  box.get(AppConstants.userData)?['mobile'] ?? "Phone Number",
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff6B7280),
                  ),
                )
              ],
            ),
          );
        });
  }
}
