import 'package:flutter/material.dart';
import 'package:laundrymart_flutter/models/store_model/store_model.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';
import 'package:laundrymart_flutter/views/dashboard/nearby_store/components/shop_info_section.dart';
import 'package:laundrymart_flutter/views/dashboard/nearby_store/components/shop_services_section.dart';

class StoreDetails extends StatelessWidget {
  const StoreDetails({super.key, required this.storeModel});
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: context.isDarkMode ? Colors.black : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          ShopInfoSection(
            store: storeModel,
          ),
          // 10.ph,
          ShopServices(
            storeModel: storeModel,
          ),
        ],
      ),
    );
  }
}
