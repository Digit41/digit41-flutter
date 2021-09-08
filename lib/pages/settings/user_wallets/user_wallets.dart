import 'dart:async';

import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/hive/wallet_model.dart';
import 'package:digit41/pages/settings/user_wallets/manage_wallet.dart';
import 'package:digit41/pages/welcome.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

void userWallets() {
  AppHive appHive = AppHive();
  List<WalletModel> wallets;
  List<Widget> items = [];
  int selectedIndex = 0;

  bottomSheet(
    Strings.YOUR_WALLETS.tr,
    enableDrag: false,
    child: FutureBuilder(
      future: appHive.getWallets(),
      builder: (BuildContext ctx, snapShot) {
        if (snapShot.hasData) {
          wallets = snapShot.data as List<WalletModel>;

          for (int i = 0; i < wallets.length; i++) {
            if (wallets[i].selected) selectedIndex = i;
            items.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListTile(
                  onTap: () async {
                    if (!wallets[i].selected) {
                      wallets[i].selected = true;
                      wallets[i].save();
                      WalletController.appGet.setWalletModel(wm: wallets[i]);

                      /// There may be no selected wallet
                      try {
                        wallets[selectedIndex].selected = false;
                        wallets[selectedIndex].save();
                      } catch (e) {}

                      appHive.box!.close();
                    }
                    Get.back();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  tileColor: wallets[i].selected
                      ? AppTheme.gray
                      : darkModeEnabled()
                          ? AppTheme.dark.scaffoldBackgroundColor
                          : Colors.grey.shade300,
                  title: Text(
                    wallets[i].name,
                    style: TextStyle(
                      color: wallets[i].selected ? Colors.white : null,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.back();
                      Timer(Duration(milliseconds: 200), () {
                        manageWallet(wallets[i]);
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: wallets[i].selected ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...items,
              const SizedBox(height: 8.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      navigateToPage(Welcome());
                    },
                    child: Image.asset(
                      Images.PLUS_ADD,
                      width: 25.0,
                      height: 25.0,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    Strings.ADD_WALLET.tr,
                    style: TextStyle(color: Get.theme.primaryColor),
                  ),
                ],
              ),
            ],
          );
        } else
          return Center(child: CupertinoActivityIndicator());
      },
    ),
  );
}
