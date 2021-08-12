import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        _anyItem('En'),
        const SizedBox(height: 8.0),
        _anyItem('Tr'),
        const SizedBox(height: 16.0),
      ],
    ),
  );
}

Widget _anyItem(String key) => ListTile(
      onTap: () {
        if (key == 'Tr') {
          _pref.setLanguageCode('tr');
          Get.updateLocale(Locale('tr', 'TU'));
        } else {
          _pref.setLanguageCode('en');
          Get.updateLocale(Locale('en', 'US'));
        }
        Get.back();
      },
      title: Text(
        _languages[key]!,
        style: TextStyle(
          color: Strings.CURRENT_LAN.tr == key ? Colors.white : null,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      tileColor: Strings.CURRENT_LAN.tr == key ? AppTheme.gray : null,
      trailing: Strings.CURRENT_LAN.tr == key
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Get.theme.primaryColor,
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.check, color: Colors.black),
            )
          : null,
    );
