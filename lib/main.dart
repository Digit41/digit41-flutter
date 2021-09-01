import 'dart:io';

import 'package:digit41/models/address_model.dart';
import 'package:digit41/models/asset_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'hive/wallet_model.dart';
import 'pages/splash.dart';
import 'utils/app_shared_preferences.dart';
import 'utils/app_theme.dart';
import 'utils/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _hiveInit();

  await Firebase.initializeApp();
  AppLocalNotification appLocalNotification = AppLocalNotification();
  appLocalNotification.initLocalNotification();
  AppFCMPushNotification appFCMPushNotification = AppFCMPushNotification();
  await appFCMPushNotification.initializeFcm();

  runApp(MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

void _hiveInit() async {
  if (GetPlatform.isWeb) {
    Hive
      ..registerAdapter(WalletAdapter())
      ..registerAdapter(AddressAdapter())
      ..registerAdapter(AssetAdapter());
  } else {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive
      ..init(directory.path)
      ..registerAdapter(WalletAdapter())
      ..registerAdapter(AddressAdapter())
      ..registerAdapter(AssetAdapter());
  }
}

class MyApp extends StatelessWidget {
  String? lanCode;

  // initial locale and _theme from platform local or preferences
  Future<bool> _initLocaleAndTheme() async {
    if (lanCode == null) {
      AppSharedPreferences pref = AppSharedPreferences();
      lanCode = await pref.getLanguageCode();
      if (lanCode == 'tr')
        Get.locale = Locale('tr', 'TU');
      else
        Get.locale = Locale('en', 'US');

      String theme = await pref.getTheme() ?? 'system';
      if (theme == 'light') {
        Get.changeTheme(AppTheme.light);
        Get.changeThemeMode(ThemeMode.light);
      } else if (theme == 'dark') {
        Get.changeTheme(AppTheme.dark);
        Get.changeThemeMode(ThemeMode.dark);
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initLocaleAndTheme(),
      builder: (ctx, snapData) {
        return snapData.hasData
            ? GetMaterialApp(
                title: 'Digit41',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                translations: AppTranslations(),
                locale: Get.locale,
                builder: (context, widget) {
                  // ignore: unnecessary_statements
                  Theme.of(context).brightness == Brightness.dark;

                  return ResponsiveWrapper.builder(
                    widget,
                    maxWidth: 700.0,
                    minWidth: 200.0,
                    defaultScale: true,
                    background: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Get.theme.scaffoldBackgroundColor,
                    ),
                    breakpoints: [
                      ResponsiveBreakpoint.resize(200.0, name: MOBILE),
                      ResponsiveBreakpoint.autoScale(700.0, name: TABLET),
                      ResponsiveBreakpoint.resize(700.0, name: DESKTOP),
                    ],
                  );
                },
                home: Splash(),
              )
            : Center();
      },
    );
  }
}
