import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcel_track/config/app_constants.dart';
import 'package:parcel_track/config/theme.dart';
import 'package:parcel_track/generated/l10n.dart';
import 'package:parcel_track/models/cart_models/hive_cart_model.dart';
import 'package:parcel_track/routes.dart';
import 'package:parcel_track/utils/globalFunction.dart';
import 'package:parcel_track/views/dashboard/profile_screen/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: false);
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.appSettingsBox);
  await Hive.openBox(AppConstants.authBox);
  await Hive.openBox(AppConstants.locationBox);
  Hive.registerAdapter(HiveCartModelAdapter());
  await Hive.openBox<HiveCartModel>(AppConstants.cartBox);
  runApp(ProviderScope(child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends ConsumerWidget {
  MyApp({super.key});
  Locale resolveLocale(String? langCode) {
    if (langCode != null) {
      return Locale(langCode);
    } else {
      return const Locale('en');
    }
  }

  bool isDarkTheme = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(AppConstants.appSettingsBox).listenable(),
          builder: (BuildContext context, Box appSettingsBox, Widget? child) {
            final isDark = appSettingsBox.get(AppConstants.isDarkTheme,
                defaultValue: false);
            if (isDark == null) {
              setTheme(value: isDarkTheme);
            }
            final selectedLocal = appSettingsBox.get(AppConstants.appLocal);
            GlobalFunction.changeStatusBarColor(
                iconBrightness: isDark ? Brightness.light : Brightness.dark);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Parcel Track',
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                FormBuilderLocalizations.delegate,
              ],
              theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
              locale: resolveLocale(selectedLocal as String?),
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (selectedLocal == null || selectedLocal == '') {
                  appSettingsBox.put(
                    AppConstants.appLocal,
                    deviceLocale?.languageCode,
                  );
                }
                for (final locale in supportedLocales) {
                  if (locale.languageCode == deviceLocale!.languageCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: generatedRoutes,
              navigatorKey: GlobalFunction.navigatorKey,
              initialRoute: Routes.splash,
              builder: EasyLoading.init(),
            );
          },
        );
      },
    );
  }
}
