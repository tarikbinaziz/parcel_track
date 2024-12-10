import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parcel_track/components/common_appBar.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/config/theme.dart';
import 'package:parcel_track/controllers/misc/misc_provider.dart';
import 'package:parcel_track/controllers/orders/orders_controller.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/order_model/order.dart';
import 'package:parcel_track/models/store_model/address.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/extensions.dart';
import 'package:parcel_track/utils/globalFunction.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/manage_address.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final Order order;

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  bool isLoading = false;

  Future<void> _downloadFile(String? url, String orderId) async {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid URL provided.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _requestPermission();

      final saveDir = await _getDownloadDirectory();
      debugPrint('saveDir: $saveDir');
      if (saveDir == null) {
        throw Exception("Unable to find a valid directory for saving files.");
      }

      final fileName = 'invoice-$orderId.pdf';
      final filePath = await _checkFileExists(orderId);

      if (filePath == null) {
        // File does not exist, start downloading
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: saveDir,
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: true,
        );

        if (taskId == null) {
          throw Exception("Failed to enqueue the download task.");
        }
        // Show a Snackbar to open the file
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Download complete: $fileName"),
            action: SnackBarAction(
              label: "Open",
              onPressed: () {
                OpenFile.open('$saveDir/$fileName');
              },
            ),
          ),
        );
      } else {
        // File exists, open it
        OpenFile.open(filePath);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> _getDownloadDirectory() async {
    Directory? appDocDir;

    if (Platform.isAndroid) {
      appDocDir = Directory('/storage/emulated/0/Download');
      if (!await appDocDir.exists()) {
        appDocDir = await getExternalStorageDirectory();
      }
    } else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
    return appDocDir?.path;
  }

  Future<void> _requestPermission() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
    }
  }

  Future<String?> _checkFileExists(String orderId) async {
    final saveDir = await _getDownloadDirectory();
    final fileName = 'invoice-$orderId.pdf';
    final filePath = '$saveDir/$fileName';
    final file = File(filePath);

    return await file.exists() ? filePath : null;
  }

  @override
  Widget build(BuildContext context) {
    final isShowServiceItem = ref.watch(showServiceItemProvider);
    String? currency =
        ref.watch(appSettingDataProvider.notifier).state.currency;
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          CommonAppBar(
            title: S.of(context).orderDetails,
            isBackButtonVisible: true,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2).r,
              decoration: BoxDecoration(
                color: GlobalFunction.getStatusColor(
                    widget.order.orderStatus ?? ''),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                widget.order.orderStatus ?? '',
                style: AppTextStyle.normalBody.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ),
          10.ph,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
                  width: double.infinity,
                  color:
                      context.isDarkMode ? AppColor.cardBlackBg : Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${S.of(context).serviceItem} (${widget.order.products?.length ?? 0})",
                          style: AppTextStyle.normalBody.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      10.pw,
                      IconButton(
                        onPressed: () {
                          ref.read(showServiceItemProvider.notifier).state =
                              !isShowServiceItem;
                        },
                        icon: Transform.rotate(
                          angle: isShowServiceItem ? 4.68 : 1.58,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 18.r,
                          ),
                        ),
                      ),
                      5.pw,
                    ],
                  ),
                ),
                2.ph,
                // Address Card
                isShowServiceItem
                    ? Container(
                        color: context.isDarkMode
                            ? AppColor.cardBlackBg
                            : Colors.white,
                        child: ListView.builder(
                          itemCount: widget.order.products?.length ?? 0,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0).r,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _orderCard(
                              title: widget.order.products?[index].name,
                              serviceName:
                                  widget.order.products?[index].serviceName,
                              imagePath:
                                  widget.order.products?[index].imagePath,
                              price: widget.order.products?[index].price ?? 0,
                              quantity:
                                  widget.order.products?[index].quantity ?? 0,
                              currency: currency,
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                10.ph,
                // Address Card
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                          .r,
                  width: double.infinity,
                  color:
                      context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(
                        color: AppColor.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        AddressCard(
                          isShowEdit: false,
                          address: Address.fromJson(
                            widget.order.address!.toJson(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                10.ph,
                // Summary
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                          .r,
                  width: double.infinity,
                  color:
                      context.isDarkMode ? AppColor.cardBlackBg : Colors.white,
                  child: Column(
                    children: [
                      _orderInfo(
                        title: S.of(context).bookingId,
                        value: widget.order.id.toString(),
                      ),
                      10.ph,
                      _orderInfo(
                        title: S.of(context).pickUpDate,
                        value: widget.order.pickDate ?? '',
                      ),
                      10.ph,
                      _orderInfo(
                        title: S.of(context).deliveryDate,
                        value: widget.order.deliveryDate ?? '',
                      ),
                      10.ph,
                      _orderInfo(
                        title: S.of(context).paymentMethod,
                        value: widget.order.paymentType ?? '',
                      ),
                      10.ph,
                      _orderInfo(
                        title: S.of(context).totalAmount,
                        value: '$currency${widget.order.payableAmount}',
                      ),
                      10.ph,
                      Align(
                        alignment: Alignment.topRight,
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () async => await _downloadFile(
                                  widget.order.invoicePath ?? '',
                                  widget.order.id.toString(),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/svgs/down_icon.svg"),
                                    5.pw,
                                    Text(
                                      S.of(context).downloadInvoice,
                                      style: AppTextStyle.normalBody.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ),

                15.ph,
                widget.order.orderStatus != "Cancelled" &&
                        widget.order.orderStatus != "Pending"
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12)
                            .r,
                        color: context.isDarkMode
                            ? AppColor.cardBlackBg
                            : Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: 50.r,
                              width: 50.r,
                              decoration: BoxDecoration(
                                color: AppColor.borderColor,
                                borderRadius: BorderRadius.circular(5).r,
                              ),
                              child: CachedNetworkImage(
                                  imageUrl: widget.order.shop?.logo ?? ''),
                            ),
                            10.pw,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Call to Shop",
                                    style: AppTextStyle.normalBody.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  3.ph,
                                  // mobile number with clickable link call with url_launcher
                                  Text(
                                    widget.order.shop?.phone ?? '',
                                    style: AppTextStyle.normalBody.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final Uri phoneNumber = Uri(
                                    scheme: 'tel',
                                    path: widget.order.shop?.phone ?? '');
                                await launchUrl(phoneNumber);
                              },
                              child: SvgPicture.asset("assets/svgs/call.svg"),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                10.pw,
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: widget.order.orderStatus == "Pending"
          ? Container(
              height: 75.h,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
              color: context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _CancelOrderDialog(
                      orderId: widget.order.id ?? 0,
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      context.isDarkMode ? AppColor.cardBlackBg : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48).r,
                    side: const BorderSide(
                      color: AppColor.borderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  S.of(context).cancelOrder,
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffEF4444),
                  ),
                ),
              ),
            )
          :
          // widget.order.orderStatus == "Delivered"
          //     ? Container(
          //         height: 75.h,
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
          //                 .r,
          //         color:
          //             context.isDarkMode ? AppColor.grayBlackBG : Colors.white,
          //         child: TextButton(
          //           onPressed: () {
          //             // add product to cart
          //             Box<HiveCartModel> cartBox =
          //                 Hive.box<HiveCartModel>(AppConstants.cartBox);
          //             Box appSettingsBox =
          //                 Hive.box(AppConstants.appSettingsBox);

          //             widget.order.products?.forEach((element) {
          //               cartBox.add(
          //                 HiveCartModel(
          //                   id: element.id ?? 0,
          //                   name: element.name ?? '',
          //                   price: element.price ?? 0,
          //                   productsQTY: element.quantity ?? 0,
          //                   thumbnail: element.imagePath ?? '',
          //                   discountPercentage: 0,
          //                   oldPrice: 0,
          //                 ),
          //               );
          //             });
          //             // calculate subtotal
          //             ref
          //                 .read(cartController)
          //                 .calculateSubTotal(cartBox.values.toList());

          //             // Store id
          //             // ref.read(storeIdProvider.notifier).state =
          //             //     widget.order.shop?.id ?? 0;

          //             appSettingsBox.put(AppConstants.storeId, widget.order.shop?.id ?? 0);

          //             // order id
          //             ref.read(orderIdProvider.notifier).state =
          //                 widget.order.id;

          //             // Navigate to shipping and payment screen
          //             context.nav
          //                 .pushNamed(Routes.shippingPayment, arguments: true);
          //           },
          //           style: TextButton.styleFrom(
          //             backgroundColor: AppColor.primaryColor,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(48).r,
          //               side: const BorderSide(
          //                 color: AppColor.borderColor,
          //                 width: 1,
          //               ),
          //             ),
          //           ),
          //           child: Text(
          //             "Order Again",
          //             style: AppTextStyle.normalBody.copyWith(
          //               fontSize: 14.sp,
          //               fontWeight: FontWeight.w600,
          //               color: AppColor.whiteColor,
          //             ),
          //           ),
          //         ),
          //       )
          //     :

          null,
      // bottomNavigationBar: SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Container(
      //         height: 75.h,
      //         padding:
      //             const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
      //         color: Colors.white,
      //         child: TextButton(
      //           onPressed: () {
      //             showDialog(
      //               context: context,
      //               builder: (context) => const _CancelOrderDialog(),
      //             );
      //           },
      //           style: TextButton.styleFrom(
      //             backgroundColor: Colors.white,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(48).r,
      //               side: const BorderSide(
      //                 color: AppColor.borderColor,
      //                 width: 1,
      //               ),
      //             ),
      //           ),
      //           child: Text(
      //             "Cancel Order",
      //             style: AppTextStyle.normalBody.copyWith(
      //               fontSize: 14.sp,
      //               fontWeight: FontWeight.w600,
      //               color: const Color(0xffEF4444),
      //             ),
      //           ),
      //         ),
      //       ),
      //       // Feedback
      //       Container(
      //         height: 75.h,
      //         padding:
      //             const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
      //         color: Colors.white,
      //         child: TextButton(
      //           onPressed: () {
      //             showDialog(
      //               context: context,
      //               builder: (context) => const _FeedBackDialog(),
      //             );
      //           },
      //           style: TextButton.styleFrom(
      //             backgroundColor: AppColor.primaryColor,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(48).r,
      //               side: const BorderSide(
      //                 color: AppColor.borderColor,
      //                 width: 1,
      //               ),
      //             ),
      //           ),
      //           child: Text(
      //             "Feedback",
      //             style: AppTextStyle.normalBody.copyWith(
      //               fontSize: 14.sp,
      //               fontWeight: FontWeight.w600,
      //               color: AppColor.whiteColor,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _orderInfo(
      {required String title,
      required String value,
      bool isHeader = false,
      bool isStatus = false}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.largeBody.copyWith(
                fontSize: 14.sp,
                fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                color: const Color(0xff6B7280),
              ),
            ),
            const Spacer(),
            !isStatus
                ? Text(
                    value,
                    style: AppTextStyle.largeBody.copyWith(
                      fontSize: 14.sp,
                      fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                    ),
                  )
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Text(
                      value,
                      style: AppTextStyle.largeBody.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Padding _orderCard({
    String? title,
    String? serviceName,
    String? imagePath,
    double price = 0,
    int quantity = 0,
    String? currency,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 2.r,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(5).r,
              ),
            ),
            10.pw,
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: AppColor.borderColor,
                borderRadius: BorderRadius.circular(5).r,
              ),
              child: CachedNetworkImage(
                imageUrl: imagePath ?? '',
              ),
            ),
            10.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName ?? '',
                    style: AppTextStyle.extraLargeBody.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff9CA3AF),
                    ),
                  ),
                  3.ph,
                  Text(
                    title ?? '',
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  3.ph,
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "$quantity X ${currency ?? ''}$price ",
                          style: AppTextStyle.extraLargeBody.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$currency${(quantity * price).toStringAsFixed(2)}",
                          style: AppTextStyle.extraLargeBody.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff39D8D8),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedBackDialog extends StatelessWidget {
  const _FeedBackDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16).r,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
      child: Padding(
        padding: const EdgeInsets.all(16).r,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/svgs/feedback_icon.svg"),
                  16.ph,
                  Text(
                    S.of(context).howWasTheService,
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  12.ph,
                  Text(
                    S.of(context).feedbackHelpImprove,
                    style: AppTextStyle.normalBody.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  12.ph,
                  RatingBar.builder(
                    initialRating: 3,
                    glowColor: Colors.amber[800],
                    glow: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16.r,
                      );
                    },
                    onRatingUpdate: (value) {
                      print(value);
                    },
                  ),
                  14.ph,
                  TextField(
                    decoration: AppTheme.inputDecoration.copyWith(
                      hintText: S.of(context).writeYourFeedbackHere,
                      hintStyle: AppTextStyle.normalBody.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff9CA3AF),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8).r,
                        borderSide: const BorderSide(
                          color: AppColor.borderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  32.ph,
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: () {},
                      text: S.of(context).submit,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelOrderDialog extends ConsumerWidget {
  const _CancelOrderDialog({required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(cancelOrderProvider);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16).r,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
      child: Consumer(
        builder: (context, ref, child) {
          return Padding(
            padding: const EdgeInsets.all(16).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/png/cancel_icon.png"),
                16.ph,
                Text(
                  S.of(context).areYouSureCancelOrder,
                  style: AppTextStyle.normalBody.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                32.ph,
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.borderColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48).r,
                          ),
                        ),
                        child: Text(
                          S.of(context).cancel,
                          style: AppTextStyle.normalBody.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    20.pw,
                    Expanded(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : TextButton(
                              onPressed: () {
                                ref
                                    .read(cancelOrderProvider.notifier)
                                    .cancelOrder(
                                      orderId: orderId,
                                    )
                                    .then((value) {
                                  if (value == true) {
                                    ref
                                        .read(homeScreenIndexProvider.notifier)
                                        .state = 2;
                                    ref.invalidate(orderListProvider);
                                    context.nav.pushNamedAndRemoveUntil(
                                        Routes.dashboardScreen,
                                        (route) => false);
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffEF4444),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(48).r,
                                ),
                              ),
                              child: Text(
                                S.of(context).confirm,
                                style: AppTextStyle.normalBody.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
