import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/controllers/others_controller/others_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/others.dart';
import 'package:parcel_track/models/store_model/address.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';

class ManageAddressScreen extends ConsumerWidget {
  const ManageAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(title: S.of(context).manageAddressTitle),
          10.ph,
          Expanded(
            child: ref.watch(addressListProvider).when(
                  data: (addressList) {
                    return addressList.isEmpty
                        ? Center(
                            child: Text(S.of(context).noAddressAvailable),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: addressList.length,
                            itemBuilder: (context, index) {
                              return AddressCard(
                                address: addressList[index],
                                isShowEdit: true,
                                isDefault: addressList[index].isDefault == 1
                                    ? true
                                    : false,
                              );
                            },
                          );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Text(S.of(context).errorText(error.toString())),
                  ),
                ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 90.h,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColor.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.greyBackgroundColor.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            context.nav.pushNamed(Routes.addOrUpdateAddress,
                arguments: AddressArg(isEditAddress: false));
          },
          style: TextButton.styleFrom(
            backgroundColor: context.isDarkMode ? AppColor.cardBlackBg : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
              side: const BorderSide(color: Color(0xff9CA3AF)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/Add to cart.svg"),
              5.pw,
              Text(
                S.of(context).newAddressButton,
                style: AppTextStyle.normalBody.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color:
                      context.isDarkMode ? Colors.white : AppColor.grayBlackBG,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddressCard extends StatelessWidget {
  AddressCard({
    super.key,
    this.isShowEdit = true,
    this.isDefault = false,
    this.address,
  });

  final Address? address;
  bool isDefault;
  bool isShowEdit;

  String processAddess(Address address) {
    String addres = '';

    if (address.houseNo != null) {
      addres = '$addres${address.houseNo}, ';
    }
    if (address.roadNo != null) {
      addres = '$addres${address.roadNo}, ';
    }
    if (address.block != null) {
      addres = '$addres${address.block}, ';
    }
    if (address.addressLine != null) {
      addres = '$addres${address.addressLine}, ';
    }
    if (address.addressLine2 != null) {
      addres = '$addres${address.addressLine2}, ';
    }
    if (address.area != null) {
      addres = '$addres${address.area}, ';
    }
    if (address.postCode != null) {
      addres = '$addres${address.postCode}';
    }
    return addres;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppConstants.authBox).listenable(),
      builder: (context, Box authBox, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
          decoration: BoxDecoration(
            color: context.isDarkMode ? AppColor.cardBlackBg : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColor.greyBackgroundColor.withOpacity(0.5),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3).r,
                    child: SvgPicture.asset(
                      "assets/svgs/location.svg",
                      height: 20.r,
                      width: 20.r,
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2)
                                  .r,
                              decoration: BoxDecoration(
                                color: AppColor.grayBlackBG,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                address?.addressName ?? "",
                                style: AppTextStyle.smallBody.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            isShowEdit
                                ? InkWell(
                                    onTap: () {
                                      context.nav.pushNamed(
                                        Routes.addOrUpdateAddress,
                                        arguments: AddressArg(
                                          address: address,
                                          isEditAddress: true,
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(
                                        "assets/svgs/edit.svg"),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        2.ph,
                        Text(
                          authBox.get(AppConstants.userData)?['name'] ?? "",
                          style: AppTextStyle.normalBody.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        2.ph,
                        Text(
                          authBox.get(AppConstants.userData)?['mobile'] ?? "",
                          style: AppTextStyle.normalBody.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff475569),
                          ),
                        ),
                        2.ph,
                        Text(
                          processAddess(address!),
                          style: AppTextStyle.normalBody.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff475569),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              10.ph,
              isDefault
                  ? Text(
                      "This is Default Address",
                      style: AppTextStyle.normalBody.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primaryColor,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
