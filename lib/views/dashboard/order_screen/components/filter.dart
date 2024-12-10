import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/orders/orders_controller.dart';
import 'package:laundrymart_flutter/generated/l10n.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';

final selectedStatusesProvider = StateProvider<List<String>>((ref) => []);

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final selectedStatuses = ref.watch(selectedStatusesProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: FormBuilder(
        key: _formKey,
        initialValue: {
          'completed': selectedStatuses.contains('delivered'),
          'pending': selectedStatuses.contains('pending'),
          'cancelled': selectedStatuses.contains('cancelled'),
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).filter,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            16.ph,
            FormBuilderCheckbox(
              name: 'completed',
              title: Text(
                S.of(context).completed,
                style: AppTextStyle.largeTitle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              checkColor: Colors.white,
              activeColor: AppColor.primaryColor,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
            FormBuilderCheckbox(
              name: 'pending',
              title: Text(
                S.of(context).pending,
                style: AppTextStyle.largeTitle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              checkColor: Colors.white,
              activeColor: AppColor.primaryColor,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
            FormBuilderCheckbox(
              name: 'cancelled',
              title: Text(
                S.of(context).cancelled,
                style: AppTextStyle.largeTitle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              checkColor: Colors.white,
              activeColor: AppColor.primaryColor,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
            // Reset and Apply TextButton in a row
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      ref.read(orderListProvider.notifier).resetData();
                      ref.read(selectedStatusesProvider.notifier).state = [];
                      context.nav.pop();
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.black.withOpacity(0.1),
                      foregroundColor: Colors.red,
                    ),
                    child: Text(
                      S.of(context).reset,
                      style: const TextStyle(),
                    ),
                  ),
                ),
                16.pw,
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      final formValues = _formKey.currentState?.value;
                      List<String> selectedStatuses = [];

                      if (formValues?['completed'] == true) {
                        selectedStatuses.add('delivered');
                      }
                      if (formValues?['pending'] == true) {
                        selectedStatuses.add('pending');
                      }
                      if (formValues?['cancelled'] == true) {
                        selectedStatuses.add('cancelled');
                      }

                      // if (selectedStatuses.isNotEmpty) {
                        ref
                            .read(orderListProvider.notifier)
                            .filterData(status: selectedStatuses);
                        ref.read(selectedStatusesProvider.notifier).state =
                            selectedStatuses;
                        context.nav.pop();
                      // } else {
                      //   debugPrint('No statuses selected');
                      // }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      S.of(context).apply,
                      style: const TextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
