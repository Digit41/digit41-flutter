import 'dart:async';

import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/hive/wallet_model.dart';
import 'package:digit41/pages/settings/any_item.dart';
import 'package:digit41/pages/settings/user_wallets/manage_wallet.dart';
import 'package:digit41/pages/welcome.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/fab_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

void userWallets() {
  WalletHive walletHive = WalletHive();
  List<WalletModel> wallets;
  List<Widget> items = [];
  int selectedIndex = 0;

  bottomSheet(
    Strings.YOUR_WALLETS.tr,
    child: FutureBuilder(
      future: walletHive.getWallets(),
      builder: (BuildContext ctx, snapShot) {
        if (snapShot.hasData) {
          wallets = snapShot.data as List<WalletModel>;

          for (int i = 0; i < wallets.length; i++) {
            if (wallets[i].selected) selectedIndex = i;
            items.add(
              anyItemOfWalletAndNetwork(
                wallets[i].name,
                wallets[i].selected,
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

                    walletHive.box!.close();
                  }
                  Get.back();
                },
                trailing: IconButton(
                  onPressed: () {
                    bottomSheetNavigateWithReplace((){
                      manageWallet(wallets[i]);
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: wallets[i].selected ? Colors.white : null,
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
              fabAdd(
                Strings.ADD_WALLET.tr,
                onTap: () {
                  navigateToPage(Welcome());
                },
              ),
            ],
          );
        } else
          return Center(child: CupertinoActivityIndicator());
      },
    ),
  );
}
