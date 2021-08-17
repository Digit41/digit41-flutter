import 'dart:async';

import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/hive/wallet_model.dart';
import 'package:digit41/pages/settings/user_wallets/manage_wallet.dart';
import 'package:digit41/pages/welcome.dart';
import 'package:digit41/utils/app_state_management.dart';
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
  int? selectedIndex;

  bottomSheet(
    Strings.YOUR_WALLETS.tr,
    enableDrag: false,
    child: FutureBuilder(
      future: appHive.getWallets(),
      builder: (BuildContext ctx, snapShot) {
        if (snapShot.hasData) {
          wallets = snapShot.data as List<WalletModel>;

          double h = wallets.length * 70.0;

          return SizedBox(
            height: wallets.length == 1
                ? 150.0
                : h < MediaQuery.of(ctx).size.height - 90.0
                    ? h
                    : MediaQuery.of(ctx).size.height - 90.0,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: wallets.length,
                itemBuilder: (ctx, int index) {
                  if (selectedIndex == null && wallets[index].selected)
                    selectedIndex = index;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: wallets.length - 1 == index ? 96.0 : 0.0,
                      top: 8.0,
                    ),
                    child: ListTile(
                      onTap: () async {
                        if (!wallets[index].selected) {
                          wallets[index].selected = true;
                          wallets[index].save();
                          AppGet.appGet.setWalletModel(wm: wallets[index]);

                          /// There may be no selected wallet
                          try {
                            wallets[selectedIndex!].selected = false;
                            wallets[selectedIndex!].save();
                          } catch (e) {}

                          appHive.box!.close();
                          Get.back();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      tileColor: wallets[index].selected
                          ? AppTheme.gray
                          : darkModeEnabled()
                              ? AppTheme.dark.scaffoldBackgroundColor
                              : Colors.grey.shade300,
                      title: Text(
                        wallets[index].name,
                        style: TextStyle(
                          color: wallets[index].selected ? Colors.white : null,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.back();
                          Timer(Duration(milliseconds: 200), (){
                            manageWallet(wallets[index]);
                          });
                        },
                        icon: Icon(
                          Icons.menu,
                          color: wallets[index].selected ? Colors.white : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: Column(
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
                  const SizedBox(height: 4.0),
                  Text(
                    Strings.ADD_WALLET.tr,
                    style: TextStyle(color: Get.theme.primaryColor),
                  ),
                ],
              ),
            ),
          );
        } else
          return Center(child: CupertinoActivityIndicator());
      },
    ),
  );
}
