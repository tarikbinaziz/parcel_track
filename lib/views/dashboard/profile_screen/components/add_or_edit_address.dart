import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:laundrymart_flutter/components/common_appBar.dart';
import 'package:laundrymart_flutter/components/custom_button.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/config/theme.dart';
import 'package:laundrymart_flutter/controllers/misc/enums.dart';
import 'package:laundrymart_flutter/controllers/misc/misc_provider.dart';
import 'package:laundrymart_flutter/controllers/others_controller/others_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/others.dart';
import 'package:laundrymart_flutter/models/store_model/address.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class AddOrEditAddressScreen extends ConsumerWidget {
  final AddressArg? addressArg;
  AddOrEditAddressScreen({super.key, this.addressArg});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _formKey2 = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(
              title: addressArg!.isEditAddress == true
                  ? "Update Address"
                  : S.of(context).addAddressTitle),
          10.ph,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _AddressFormSection(
                    formKey: _formKey,
                    address: addressArg?.address,
                    isEditAddress: addressArg?.isEditAddress,
                  ),
                  10.ph,
                  _AddressTagSection(
                    formKey: _formKey2,
                    address: addressArg?.address,
                    isEditAddress: addressArg?.isEditAddress,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final isLoading = ref.watch(addAddressProvider);
          final isLoadingUpdate = ref.watch(updateAddressProvider);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
            height: 90.h,
            child: isLoading || isLoadingUpdate
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: addressArg!.isEditAddress == true
                          ? "Update"
                          : S.of(context).saveButtonText,
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate() &&
                            _formKey2.currentState!.saveAndValidate()) {
                          final data = {
                            ..._formKey.currentState!.value,
                            "is_default":
                                _formKey2.currentState!.value['is_default'] ==
                                        true
                                    ? 1
                                    : 0,
                            "address_name": ref
                                .read(selectedAddressTagProvider.notifier)
                                .state
                                .toString()
                                .split('.')
                                .last,
                          };

                          if (addressArg?.isEditAddress == false) {
                            ref
                                .read(addAddressProvider.notifier)
                                .addAddress(data: data)
                                .then((value) {
                              if (value == true) {
                                ref.invalidate(addressListProvider);
                                // clear the form
                                _formKey.currentState!.reset();
                                _formKey2.currentState!.reset();
                                // show snackbar
                                EasyLoading.showSuccess(
                                        S.of(context).addressAddedSuccess)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          } else {
                            ref
                                .read(updateAddressProvider.notifier)
                                .updateAddress(
                                    data: data,
                                    id: addressArg?.address?.id ?? 0)
                                .then((value) {
                              if (value == true) {
                                ref.invalidate(addressListProvider);
                                // clear the form
                                _formKey.currentState!.reset();
                                _formKey2.currentState!.reset();
                                // show snackbar
                                EasyLoading.showSuccess(
                                        S.of(context).addressUpdatedSuccess)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          }
                        }
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _AddressTagSection extends ConsumerWidget {
  const _AddressTagSection({
    required GlobalKey<FormBuilderState> formKey,
    this.address,
    this.isEditAddress,
  }) : _formKey = formKey;
  final GlobalKey<FormBuilderState> _formKey;
  final Address? address;
  final bool? isEditAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddressTag = ref.watch(selectedAddressTagProvider);
    return FormBuilder(
      key: _formKey,
      initialValue: {
        'is_default': address?.isDefault == 1 ? true : false,
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).addressTagTitle,
                  style: AppTextStyle.largeBody.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                8.ph,
                Row(
                  children: List.generate(AddressTag.values.length, (index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            ref
                                .read(selectedAddressTagProvider.notifier)
                                .state = AddressTag.values[index];
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10)
                                .r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              border:
                                  selectedAddressTag == AddressTag.values[index]
                                      ? Border.all(color: AppColor.primaryColor)
                                      : Border.all(color: AppColor.borderColor),
                            ),
                            child: Text(
                              AddressTag.values[index]
                                  .toString()
                                  .split('.')
                                  .last
                                  .toUpperCase(),
                              style: AppTextStyle.normalBody.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: selectedAddressTag ==
                                        AddressTag.values[index]
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
          ),
          1.5.ph,
          Container(
            color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderCheckbox(
                    name: 'is_default',
                    title: Text(S.of(context).makeItDefaultAddress),
                    checkColor: AppColor.whiteColor,
                    activeColor: AppColor.primaryColor,
                    visualDensity:
                        const VisualDensity(horizontal: -4.0, vertical: -4.0),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      isCollapsed: true,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isLoading = ref.watch(deleteAddressProvider);
                    return isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : InkWell(
                            onTap: () {
                              ref
                                  .read(deleteAddressProvider.notifier)
                                  .deleteAddress(id: address?.id ?? 0)
                                  .then((value) {
                                if (value == true) {
                                  ref.invalidate(addressListProvider);
                                  EasyLoading.showSuccess(
                                          "Address deleted successfully")
                                      .then((value) {
                                    Navigator.pop(context);
                                    ref.invalidate(addressListProvider);
                                  });
                                }
                              });
                            },
                            child: Text(
                              "Delete this",
                              style: AppTextStyle.normalBody.copyWith(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressFormSection extends ConsumerStatefulWidget {
  final Address? address;
  final bool? isEditAddress;
  const _AddressFormSection({
    required GlobalKey<FormBuilderState> formKey,
    this.address,
    this.isEditAddress,
  }) : _formKey = formKey;
  final GlobalKey<FormBuilderState> _formKey;

  @override
  ConsumerState<_AddressFormSection> createState() => _AddressFormState();
}

class _AddressFormState extends ConsumerState<_AddressFormSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
      color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      width: double.infinity,
      child: FormBuilder(
        key: widget._formKey,
        initialValue: {
          'area': widget.address?.area,
          'flat_no': widget.address?.flatNo,
          'post_code': widget.address?.postCode,
          'address_line': widget.address?.addressLine,
          'address_line2': widget.address?.addressLine2,
        },
        child: Column(
          children: [
            // Area, Flat, Postal in a row
            Row(
              children: [
                // Area
                Expanded(
                  child: FormBuilderTextField(
                    name: 'area',
                    decoration: AppTheme.inputDecoration.copyWith(
                      labelText: S.of(context).areaLabel,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                10.pw,
                // Flat
                Expanded(
                  child: FormBuilderTextField(
                    name: 'flat_no',
                    decoration: AppTheme.inputDecoration.copyWith(
                      labelText: S.of(context).flatLabel,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                10.pw,
                // Postal
                Expanded(
                  child: FormBuilderTextField(
                    name: 'post_code',
                    decoration: AppTheme.inputDecoration.copyWith(
                      labelText: S.of(context).postalLabel,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
              ],
            ),
            20.ph,
            // Address Line 1
            FormBuilderTextField(
              name: 'address_line',
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: S.of(context).addressLine1Label,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            20.ph,
            // Address Line 2
            FormBuilderTextField(
              name: 'address_line2',
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: S.of(context).addressLine2Label,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
