import 'package:digit41/app_web3/utils.dart';
import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/pages/settings/accounts/create_account.dart';
import 'package:digit41/pages/settings/any_item.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/fab_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void accounts() {
  WalletController walletCtl = WalletController.walletCtl;

  bottomSheet(
    Strings.ACCOUNTS.tr,
    child: SizedBox(
      /// adjust the height to expand the display list according to the content
      /// means --> 60.0 * addressList.length
      /// and also above value + with 100.0 for stay on fab below of list
      height: 60.0 * walletCtl.walletModel!.addresses!.length + 100.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: walletCtl.walletModel!.addresses!.length,
              itemBuilder: (ctx, int index) {
                return anyItemOfWalletAndNetwork(
                  walletCtl.walletModel!.addresses![index].name,
                  index == walletCtl.walletModel!.selectedAddressIndex,
                  trailing: Text(
                    showAddress(
                      walletCtl.walletModel!.addresses![index]!.address,
                    ),
                    style: TextStyle(fontSize: 12.0),
                  ),
                  onTap: () {
                    if (index != walletCtl.walletModel!.selectedAddressIndex) {
                      walletCtl.walletModel!.selectedAddressIndex = index;
                      walletCtl.walletModel!.save();
                      AssetsController.assetsController.refreshAssets();
                      walletCtl.forUpdateUI();
                    }
                    Get.back();
                  },
                );
              },
            ),
          ),
          fabAdd(
            Strings.CREATE.tr + ' ' + Strings.ACCOUNT.tr,
            onTap: () {
              bottomSheetNavigateWithReplace(createAccount);
            },
          ),
        ],
      ),
    ),
  );
}
