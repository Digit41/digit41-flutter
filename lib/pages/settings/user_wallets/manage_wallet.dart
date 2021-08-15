import 'package:digit41/hive/wallet_model.dart';
import 'package:digit41/pages/settings/user_wallets/term_of_recovery_phrase.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:digit41/widgets/inner_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageWallet extends StatelessWidget {
  WalletModel _wallet;

  AppTextFormField? _walletName;

  ManageWallet(this._wallet) {
    _walletName = AppTextFormField(hint: Strings.WALLET_NAME.tr);
    _walletName!.controller.text = _wallet.name;
  }

  Widget _txt(String txt) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Text(txt),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        save();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                InnerAppbar(title: _wallet.name),
                const SizedBox(height: 32.0),
                _txt(Strings.WALLET_NAME.tr),
                _walletName!,
                const SizedBox(height: 32.0),
                _txt(Strings.BACKUP_OPTIONS.tr),
                AppButton(
                  title: Strings.SHOW_REC_PHRASES.tr,
                  titleColor: darkModeEnabled() ? Colors.white : Colors.white,
                  borderColor: darkModeEnabled() ? Colors.white : null,
                  btnColor: darkModeEnabled() ? null : AppTheme.gray,
                  onTap: () {
                    navigateToPage(TermOfRecPhrase());
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
          ),
        ),
      ),
    );
  }

  void save() {
    if (_wallet.name != _walletName!.controller.text) {
      _wallet.name = _walletName!.controller.text;
      _wallet.save();
      AppGet.appGet.setWalletModel(wm: _wallet);
    }
  }
}
