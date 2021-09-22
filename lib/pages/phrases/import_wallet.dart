import 'package:bip39/bip39.dart' as bip39;
import 'package:clipboard/clipboard.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/models/wallet_model.dart';
import 'package:digit41/utils/app_permission.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_navigation.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

void importWallet() async {
  Get.bottomSheet(
    _ImportWallet(),
    isScrollControlled: true,
    backgroundColor: Get.theme.bottomSheetTheme.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0),
      ),
    ),
  );
}

class _ImportWallet extends StatelessWidget {
  WalletHive walletHive = WalletHive();
  final formKey = GlobalKey<FormState>();
  AppTextFormField? name;
  AppTextFormField phrases = AppTextFormField(
    hint: Strings.PHRASE.tr,
    maxLine: 5,
    validator: (String? value) {
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
    },
  );

  _ImportWallet({Key? key}) : super(key: key) {
    phrases.suffixIcon = Column(
      children: [
        const SizedBox(height: 100.0),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
            onPressed: () {
              FlutterClipboard.paste().then((value) {
                phrases.controller.text = value;
              });
            },
            child: Text(
              Strings.PASTE.tr,
              style: TextStyle(color: Get.theme.primaryColor),
            ),
          ),
        ),
      ],
    );
    name = AppTextFormField(
      hint: Strings.NAME.tr,
      nextFocusNode: phrases.focusNode,
    );

    init();
  }

  void init() async {
    int countWall;
    Box box = await walletHive.getBox();
    countWall = box.length + 1;
    name!.controller.text = 'Wallet $countWall';
    box.close();
  }

  void import() async {
    bool isAllow = true;
    if (!GetPlatform.isWeb) isAllow = await storagePermission();

    if (formKey.currentState!.validate() && isAllow) {
      WalletModel walletModel = await walletHive.configureWallet(
        phrases.controller.text,
        name: name!.controller.text,
      );

      /// set active wallet
      WalletController.appGet.setWalletModel(wm: walletModel);

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Strings.IMPORT.tr + ' ' + Strings.WALLET.tr,
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  GetPlatform.isWeb
                      ? Center()
                      : InkWell(
                          onTap: () async {
                            String re = await barcodeScan();
                            phrases.controller.text = re;
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Images.SCAN,
                                width: 20.0,
                                height: 20.0,
                                color: Get.theme.primaryColor,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                Strings.SCAN_QR.tr,
                                style: TextStyle(color: Get.theme.primaryColor),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 16.0),
              phrases,
              const SizedBox(height: 8.0),
              Text(
                Strings.DESC_IMPORT_WALL.tr,
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox(height: 16.0),
              Text(Strings.WALLET_NAME.tr),
              const SizedBox(height: 8.0),
              name!,
              const SizedBox(height: 32.0),
              TextButton(
                onPressed: () {},
                child: Text(Strings.Q_IMPORT_WALL.tr),
              ),
              if (GetPlatform.isWeb) const SizedBox(height: 8.0),
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
}
