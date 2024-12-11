import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcel_track/components/custom_button.dart';
import 'package:parcel_track/config/app_color.dart';
import 'package:parcel_track/config/app_text.dart';
import 'package:parcel_track/config/theme.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedPayer = "Me";

  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: ListView(
          children: [
            // Dropdown for item type
            Text(
              'What are you sending',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField(
              hint: Text(
                'Select item type',
                style: AppTextStyle.smallBody,
              ),
              items: const [
                DropdownMenuItem(value: 'Document', child: Text('Document')),
                DropdownMenuItem(value: 'Gadget', child: Text('Gadget')),
              ],
              onChanged: (value) {},
              decoration: AppTheme.inputDecoration,
              //  InputDecoration(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(8.r),
              //     borderSide: const BorderSide(color: AppColor.primaryColor),
              //   ),
              // ),
            ),
            SizedBox(height: 8.h),
            Text(
              '⚠️ Prohibited items include hazardous materials, illegal goods, perishables, and items restricted by law.',
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),

            SizedBox(height: 16.h),

            // Quantity input
            Text(
              'Quantity',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: AppTheme.inputDecoration.copyWith(
                hintText: "0",
                hintStyle: AppTextStyle.smallBody,
              ),
            ),

            SizedBox(height: 16.h),

            // Select who pays
            Text(
              'Select who pays',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Radio(
                  value: 'Me',
                  groupValue: selectedPayer,
                  activeColor: AppColor.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      selectedPayer = value as String;
                    });
                  },
                ),
                Text('Me', style: TextStyle(fontSize: 14.sp)),
                SizedBox(width: 16.w),
                Radio(
                  value: 'Recipient',
                  groupValue: selectedPayer,
                  activeColor: AppColor.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      selectedPayer = value as String;
                    });
                  },
                ),
                Text('Recipient', style: TextStyle(fontSize: 14.sp)),
              ],
            ),

            // Payment type dropdown
            DropdownButtonFormField(
              hint: const Text(
                'Select payment type',
              ),
              items: const [
                DropdownMenuItem(value: 'Card', child: Text('Card')),
                DropdownMenuItem(value: 'Cash', child: Text('Cash')),
              ],
              onChanged: (value) {},
              decoration: AppTheme.inputDecoration,
            ),

            SizedBox(height: 16.h),

            // Recipient name
            Text(
              'Recipient Name',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: AppTheme.inputDecoration.copyWith(
                  hintText: "Enter name", hintStyle: AppTextStyle.smallBody),
            ),

            SizedBox(height: 16.h),

            // Recipient contact number,

            Text(
              'Recipient contact number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              decoration: AppTheme.inputDecoration.copyWith(
                  hintText: "Enter number", hintStyle: AppTextStyle.smallBody),
            ),

            SizedBox(height: 16.h),

            // Upload package picture
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.r)),
                  ),
                  builder: (context) => _buildImagePickerOptions(),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          File(_image!.path),
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    else ...[
                      Icon(FontAwesomeIcons.camera,
                          size: 24.sp, color: Colors.grey),
                      SizedBox(height: 8.h),
                      Text('Take a picture of the package',
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.grey)),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Continue button,
            CustomButton(onPressed: () {}, text: 'Continue'),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOptions() {
    return SizedBox(
      height: 120.h,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.blue),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.green),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
