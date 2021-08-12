import 'package:bip39/bip39.dart' as bip39;
import 'package:clipboard/clipboard.dart';
import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/hive/wallet_model.dart';
import 'package:digit41/utils/app_permission.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_navigation.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ImportWallet extends StatefulWidget {
  @override
  _ImportWalletState createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  final formKey = GlobalKey<FormState>();
  AppTextFormField? name;
  AppTextFormField? phrases;

  AppHive? appHive;

  void initName() async {
    appHive = AppHive();
    int countWall;
    Box box = await appHive!.getBox(SecureKey.HIVE_WALLET_BOX);
    countWall = box.length + 1;
    name!.controller.text = 'Wallet $countWall';
    box.close();
  }

  Widget suffixPhrase() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                FlutterClipboard.paste().then((value) {
                  phrases!.controller.text = value;
                });
              },
              child: Text(Strings.PASTE.tr),
            ),
            if (!GetPlatform.isWeb)
              IconButton(
                onPressed: () async {
                  String re = await barcodeScan();
                  phrases!.controller.text = re;
                },
                icon: Icon(Icons.qr_code_scanner, color: Colors.blue),
              ),
          ],
        ),
      );

  String? validatorPhrase(String? value) {
    if (value!.isEmpty)
      return Strings.PLEASE.tr +
          ' ' +
          Strings.ENTER_SELF.tr +
          ' ' +
          Strings.PHRASE.tr;

    value = value.trim();
    /**
        This pattern means "at least one space, or more"
        \s : space
        +   : one or more
     */
    value = value.replaceAll(RegExp(r"\s+"), " ");
    if (bip39.validateMnemonic(value))
      return null;
    else
      return Strings.INVALID.tr + ' ' + Strings.PHRASE.tr;
  }

  @override
  void initState() {
    super.initState();
    phrases = AppTextFormField(
      hint: Strings.PHRASE.tr,
      maxLine: 3,
      suffixIcon: suffixPhrase(),
      validator: validatorPhrase,
    );
    name = AppTextFormField(
      hint: Strings.NAME.tr,
      nextFocusNode: phrases!.focusNode,
    );

    initName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 64.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48.0),
                child: Text(
                  Strings.DESC_IMPORT_WALL.tr,
                  style: TextStyle(fontSize: 26.0),
                ),
              ),
              name!,
              SizedBox(height: 16.0),
              phrases!,
              Expanded(child: Center()),
              AppButton(
                title: Strings.IMPORT.tr,
                onTap: import,
                btnColor: Get.theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void import() async {
    if (formKey.currentState!.validate() && await storagePermission()) {
      WalletModel walletModel = await appHive!.configureWallet(
        phrases!.controller.text,
        name: name!.controller.text,
      );

      /// set active wallet
      AppGet.appGet.setWalletModel(wm: walletModel);

      bottomSheet(
        'DIGIT41',
        message: Strings.IMPORT_DESC.tr,
        enableDrag: false,
        isDismissible: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Center(
            child: TextButton(
              onPressed: () {
                navigateToPage(BottomNavigation(), popAll: true);
              },
              child: Text(
                Strings.OK.tr,
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 20.0),
              ),
            ),
          ),
        ),
      );
    }
  }
}
