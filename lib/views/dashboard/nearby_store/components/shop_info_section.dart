import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/models/store_model/address.dart';
import 'package:laundrymart_flutter/models/store_model/store_model.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

class ShopInfoSection extends StatelessWidget {
  const ShopInfoSection({
    super.key,
    required this.store,
  });

  final StoreModel store;

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16).r,
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: store.logo ?? '',
            ),
          ),
          10.pw,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.ph,
              Text(
                store.name ?? '',
                style: AppTextStyle.normalBody.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              4.ph,
              Row(
                children: [
                  Icon(Icons.location_on, size: 16.r, color: Colors.red),
                  Expanded(
                    child: Text(
                      processAddess(store.address!),
                    ),
                  ),
                ],
              ),
              4.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(store.distance ?? ''),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16.r,
                        color: const Color(0xffF4B30C),
                      ),
                      Text(store.averageRating ?? '0'),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 60, 189, 64),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      S.of(context).openNow,
                      style: AppTextStyle.smallBody.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              10.ph,
            ],
          ))
        ],
      ),
    );
  }
}
