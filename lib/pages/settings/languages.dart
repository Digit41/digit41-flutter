import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'any_item.dart';

/// keys is values of CURRENT_LAN into Strings
final _languages = {
  'En': 'English',
  'Tr': 'Turkish',
};

AppSharedPreferences _pref = AppSharedPreferences();

void languagesBottomSheet() {
  bottomSheet(
    Strings.LANGUAGE.tr,
    child: Column(
      children: [
        const SizedBox(height: 16.0),
        anyItem(
          _languages['En']!,
          Strings.CURRENT_LAN.tr == 'En',
          onTap: () {
            _pref.setLanguageCode('en');
            Get.updateLocale(Locale('en', 'US'));
            Get.back();
          },
        ),
        const SizedBox(height: 8.0),
        anyItem(
          _languages['Tr']!,
          Strings.CURRENT_LAN.tr == 'Tr',
          onTap: () {
            _pref.setLanguageCode('tr');
            Get.updateLocale(Locale('tr', 'TU'));
            Get.back();
          },
        ),
        const SizedBox(height: 16.0),
      ],
    ),
  );
}
