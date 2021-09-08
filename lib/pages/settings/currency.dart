import 'package:digit41/models/currency_model.dart';
import 'package:digit41/pages/settings/any_item.dart';
import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppSharedPreferences _pref = AppSharedPreferences();

void currencyBottomSheet(String currencyKey) {
  List<CurrencyModel> cL = [
    CurrencyModel('USD', 'US Dollar'),
    CurrencyModel('EUR', 'Euro'),
    CurrencyModel('ETH', 'Ether'),
  ];

  bottomSheet(
    Strings.CURRENCY.tr,
    child: FutureBuilder(
      builder: (ctx, snapData) => SizedBox(
        height: cL.length * 60.0,
        child: ListView.builder(
          itemCount: cL.length,
          itemBuilder: (contx, int index) => anyItem(
            cL[index].value,
            cL[index].key == currencyKey,
            onTap: () {
              _pref.saveCurrency(cL[index].key);
              AppGet.appGet.forUpdateUI();
              Get.back();
            },
          ),
        ),
      ),
    ),
  );
}