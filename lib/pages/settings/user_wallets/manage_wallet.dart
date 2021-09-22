import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/models/wallet_model.dart';
import 'package:digit41/pages/settings/user_wallets/term_of_recovery_phrase.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void manageWallet(WalletModel wallet) {
  AppTextFormField? walletName = AppTextFormField(hint: Strings.WALLET_NAME.tr);
  walletName.controller.text = wallet.name;

  Widget _txt(String txt) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Text(txt),
      );

  bottomSheet(
    wallet.name,
    frontOfTitle: IconButton(
      onPressed: () {
        if (wallet.name != walletName.controller.text) {
          wallet.name = walletName.controller.text;
          wallet.save();
          if (wallet.selected) WalletController.appGet.setWalletModel(wm: wallet);
        }
        Get.back();
      },
      icon: Icon(Icons.check, color: Get.theme.primaryColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        _txt(Strings.WALLET_NAME.tr),
        walletName,
        const SizedBox(height: 24.0),
        _txt(Strings.BACKUP_OPTIONS.tr),
        AppButton(
          title: Strings.SHOW_REC_PHRASES.tr,
          titleColor: darkModeEnabled() ? Colors.white : Colors.white,
          borderColor: darkModeEnabled() ? Colors.white : null,
          btnColor: darkModeEnabled() ? null : AppTheme.gray,
          onTap: () {
            termOfRecPhrase(wallet.mnemonic);
          },
        ),
        _txt(Strings.DESC_SHOW_REC_PHRASES.tr),
        // const SizedBox(height: 32.0),
        // _txt(Strings.ACCOUNT_PUBLIC_KEYS.tr),
        // AppButton(
        //   title: Strings.EXPORT_ACC_PUB_KEYS.tr,
        //   titleColor: darkModeEnabled() ? Colors.white : Colors.white,
        //   borderColor: darkModeEnabled() ? Colors.white : null,
        //   btnColor: darkModeEnabled() ? null : AppTheme.gray,
        //   onTap: () {},
        // ),
      ],
    ),
  );
}
