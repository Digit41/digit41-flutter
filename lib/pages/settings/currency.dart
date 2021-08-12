import 'package:digit41/models/currency_model.dart';
import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/app_theme.dart';
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
          itemBuilder: (contx, int index) => _anyItem(
            cL[index],
            cL[index].key == currencyKey,
          ),
        ),
      ),
    ),
  );
}

Widget _anyItem(CurrencyModel currencyModel, bool selected) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        onTap: () {
          _pref.saveCurrency(currencyModel.key);

          AppGet.appGet.forUpdateUI();

          Get.back();
        },
        title: Text(
          currencyModel.value,
          style: TextStyle(color: selected ? Colors.white : null),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        tileColor: selected ? AppTheme.gray : null,
        trailing: selected
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Get.theme.primaryColor,
                ),
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.check, color: Colors.black),
              )
            : null,
      ),
    );
