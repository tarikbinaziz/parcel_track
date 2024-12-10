import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundrymart_flutter/config/app_color.dart';

class AppTheme {
  AppTheme._();

  // static ThemeData newTheme = ThemeData(
  //   fontFamily: "Roboto",
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: AppColor.primaryColor,
  //     surface: AppColor.primaryColor,
  //     onSurface: Colors.black,
  //     surfaceContainerHighest: Colors.blue,
  //     secondary: Colors.green,
  //     onSecondary: Colors.yellow,
  //     primary: AppColor.primaryColor,
  //   ),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.blue,
  //       backgroundColor: Colors.red,
  //     ),
  //   ),
  //   scaffoldBackgroundColor: Colors.white,
  // );

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Rotobo',
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.greyBackgroundColor,
    canvasColor: AppColor.whiteColor,
    brightness: Brightness.light,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Rotobo',
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.grayBlackBG,
    brightness: Brightness.dark,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      modalBarrierColor: Colors.white.withOpacity(0.5),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );

  static InputDecoration inputDecoration = InputDecoration(
    labelStyle: const TextStyle(
      color: Color(0xff9CA3AF),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColor.borderColor,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColor.borderColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(
        color: AppColor.primaryColor,
      ),
    ),
  );
}
