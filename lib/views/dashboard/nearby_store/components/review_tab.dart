import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';
import 'package:laundrymart_flutter/config/app_text.dart';
import 'package:laundrymart_flutter/controllers/dashboard/dashboard_controller.dart';
import 'package:laundrymart_flutter/utils/extensions.dart';
import 'package:laundrymart_flutter/models/all_ratinngs_model/data.dart'
    as rData;

class ReviewTab extends ConsumerWidget {
  const ReviewTab({super.key, required this.storeId});

  final int storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(reviewControllerProvider(storeId: storeId)).when(
      data: (rating) {
        return rating == null
            ? const Center(
                child: Text("No Rating Found"),
              )
            : Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                            .r,
                    child: _RatingSection(
                      data: rating.data!,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: rating.data?.ratings?.length == null ||
                            rating.data!.ratings!.isEmpty
                        ? const Center(
                            child: Text("No Rating Available"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            itemCount: rating.data?.ratings?.length ?? 0,
                            itemBuilder: (context, index) {
                              final data = rating.data!.ratings![index];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16)
                                    .r,
                                margin: EdgeInsets.only(
                                    top: 16.r, left: 16.r, right: 16.r),
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? AppColor.cardBlackBg
                                      : AppColor.greyBackgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.r),
                                  ),
                                  border: Border.all(
                                    color: AppColor.borderColor,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundImage: NetworkImage(
                                                data.img ?? "",
                                              ),
                                            ),
                                            10.pw,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.name ?? "No Name",
                                                  style: AppTextStyle.largeBody,
                                                ),
                                                Text(
                                                  data.date ?? "No Date",
                                                  style: AppTextStyle.normalBody
                                                      .copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xff6B7280),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: List.generate(
                                              data.rating ?? 0, (index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Color(0xffF4B30C),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    8.ph,
                                    Text(
                                      data.content ?? "No Review",
                                      style: AppTextStyle.normalBody.copyWith(
                                        color: const Color(0xff6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
      },
      error: (e, s) {
        return Center(
          child: Text(e.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _RatingSection extends StatefulWidget {
  const _RatingSection({required this.data});
  final rData.Data data;

  @override
  State<_RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<_RatingSection>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<double> starList = [
      double.parse(widget.data.star5 ?? '0'),
      double.parse(widget.data.star4 ?? '0'),
      double.parse(widget.data.star3 ?? '0'),
      double.parse(widget.data.star2 ?? '0'),
      double.parse(widget.data.star1 ?? '0'),
    ];
    return Row(
      children: [
        Column(
          children: [
            Text(
              widget.data.average ?? "0.0",
              style: AppTextStyle.extraLargeBody,
            ),
            Row(
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: Color(0xffF4B30C),
                );
              }),
            ),
            Text(
              "${widget.data.totalStar ?? 0} reviews",
              style: AppTextStyle.normalBody.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        16.pw,
        Expanded(
          child: Column(
            children: List.generate(5, (index) {
              int i = 5 - (index + 1);
              return Row(
                children: [
                  Text((index + 1).toString()),
                  8.pw,
                  Expanded(
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween<double>(begin: 0, end: starList[i] / 100),
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: value,
                          color: const Color(0xffF4B30C),
                          minHeight: 6.r,
                          borderRadius: BorderRadius.circular(6.r),
                        );
                      },
                    ),
                  ),
                ],
              );
            }).reversed.toList(),
          ),
        )
      ],
    );
  }
}
