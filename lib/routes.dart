import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parcel_track/models/order_model/order.dart';
import 'package:parcel_track/models/others.dart';
import 'package:parcel_track/views/auth/components/phone_verification.dart';
import 'package:parcel_track/views/auth/login_screen.dart';
import 'package:parcel_track/views/auth/signup_screen.dart';
import 'package:parcel_track/views/dashboard/dashboard_screen.dart';
import 'package:parcel_track/views/dashboard/home_screen/confirm_details_screen.dart';
import 'package:parcel_track/views/dashboard/home_screen/courier_details_screen.dart';
import 'package:parcel_track/views/dashboard/home_screen/details.dart';
import 'package:parcel_track/views/dashboard/home_screen/instant_delivery_screen.dart';
import 'package:parcel_track/views/dashboard/order_screen/components/order_details.dart';
import 'package:parcel_track/views/dashboard/payment/shipping_and_payment.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/about_us.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/add_or_edit_address.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/manage_address.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/privacy_and_policy.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/profile_update.dart';
import 'package:parcel_track/views/dashboard/profile_screen/components/terms_and_conditions.dart';
import 'package:parcel_track/views/splash_screen/on_boarding.dart';
import 'package:parcel_track/views/splash_screen/splash_screen.dart';

class Routes {
  /*We are mapping all th eroutes here
  so that we can call any named route
  without making typing mistake
  */
  Routes._();
  //core
  static const splash = '/';
  static const login = '/login';
  static const signUp = '/signUp';
  static const onBoardingScreen = '/onBoardingScreen';
  static const phoneVerification = '/phoneVerification';
  static const dashboardScreen = '/dashboardScreen';
  static const instantDeliveryScreen = '/instantDeliveryScreen';
  static const detailsScreen = '/details';
  static const confirmDetailsScreen = '/confirmdetails';
  static const courierDetailsScreen = '/courierDetails';


  static const cartScreen = '/cartScreen';
  static const shippingPayment = '/shippingPayment';
  static const manageAddress = '/manageAddress';
  static const addOrUpdateAddress = '/addAddress';
  static const orderDetails = '/orderDetails';
  static const profileScreen = '/profileScreen';
  static const serviceBasedStores = '/serviceBasedStores';
  static const storeDetails = '/shopDetails';
  static const termsAndConditions = '/termsAndConditions';
  static const privacyPolicy = '/privacyPolicy';
  static const aboutUs = '/aboutUs';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    //core
    case Routes.splash:
      child = const SplashScreen();
      break;

    case Routes.login:
      child = const LoginScreen();
      break;

    case Routes.signUp:
      child = const SignUpScreen();
      break;

    case Routes.onBoardingScreen:
      child = OnBoardingScreen();
      break;

    case Routes.phoneVerification:
      child = const PhoneVerification();
      break;

    case Routes.dashboardScreen:
      child = const DashBoardScreen();
      break;

    case Routes.instantDeliveryScreen:
      child = const InstantDeliveryScreen();
      break;

    case Routes.detailsScreen:
      child = const DetailsScreen();
      break;
    case Routes.confirmDetailsScreen:
      child = const ConfirmDetailsScreen();
      break;
    case Routes.courierDetailsScreen:
      child = const CourierDetailsScreen();
      break;






    case Routes.shippingPayment:
      child = ShippingAndPayment(isReOrder: settings.arguments as bool);
      break;

    case Routes.manageAddress:
      child = const ManageAddressScreen();
      break;

    case Routes.addOrUpdateAddress:
      child = AddOrEditAddressScreen(
        addressArg: settings.arguments as AddressArg?,
      );
      break;

    case Routes.orderDetails:
      child = OrderDetailsScreen(
        order: settings.arguments as Order,
      );
      break;

    case Routes.profileScreen:
      child = ProfileUpdateScreen();
      break;

    case Routes.termsAndConditions:
      child = const TermsAndConditions();
      break;

    case Routes.privacyPolicy:
      child = const PrivacyAndPolicy();
      break;

    case Routes.aboutUs:
      child = const AboutUs();
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  debugPrint("Route: ${settings.name}");
  return PageTransition(
    child: child,
    type: PageTransitionType.fade,
    settings: settings,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
  );
}
