import 'package:flutter/material.dart';
import 'package:laundrymart_flutter/models/order_model/order.dart';
import 'package:laundrymart_flutter/models/others.dart';
import 'package:laundrymart_flutter/models/store_model/store_model.dart';
import 'package:laundrymart_flutter/views/auth/components/phone_verification.dart';
import 'package:laundrymart_flutter/views/auth/login_screen.dart';
import 'package:laundrymart_flutter/views/auth/signup_screen.dart';
import 'package:laundrymart_flutter/views/cart/my_cart_screen.dart';
import 'package:laundrymart_flutter/views/dashboard/dashboard_screen.dart';
import 'package:laundrymart_flutter/views/dashboard/nearby_store/store_details.dart';
import 'package:laundrymart_flutter/views/dashboard/order_screen/components/order_details.dart';
import 'package:laundrymart_flutter/views/dashboard/payment/shipping_and_payment.dart';
import 'package:laundrymart_flutter/views/dashboard/profile_screen/components/about_us.dart';
import 'package:laundrymart_flutter/views/dashboard/profile_screen/components/add_or_edit_address.dart';
import 'package:laundrymart_flutter/views/dashboard/profile_screen/components/manage_address.dart';
import 'package:laundrymart_flutter/views/dashboard/profile_screen/components/privacy_and_policy.dart';
import 'package:laundrymart_flutter/views/dashboard/profile_screen/components/profile_update.dart';
import 'package:laundrymart_flutter/views/dashboard/profile_screen/components/terms_and_conditions.dart';
import 'package:laundrymart_flutter/views/dashboard/service_screen/components/service_based_stores.dart';
import 'package:laundrymart_flutter/views/dashboard/service_screen/product_screen.dart';
import 'package:laundrymart_flutter/views/splash_screen/on_boarding.dart';
import 'package:laundrymart_flutter/views/splash_screen/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

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
  static const productScreen = '/serviceScreen';
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

    case Routes.productScreen:
      child = ProductScreen(
        arg: settings.arguments as ServiceArg,
      );
      break;

    case Routes.storeDetails:
      child = StoreDetails(
        storeModel: settings.arguments as StoreModel,
      );
      break;

    case Routes.cartScreen:
      child = const CartScreen();
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

    case Routes.serviceBasedStores:
      child = ServiceBasedStores(
        serviceID: settings.arguments as int,
      );
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
