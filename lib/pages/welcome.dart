import 'dart:async';

import 'package:digit41/pages/phrases/backup.dart';
import 'package:digit41/utils/app_permission.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'phrases/import_wallet.dart';

class Welcome extends StatelessWidget {
  Welcome() {
    if (GetPlatform.isAndroid || GetPlatform.isIOS)
      Timer(Duration(microseconds: 300), () async {
        showDialogPermission();
      });
  }

  void showDialogPermission() async {
    if (!await isGrantedStoragePer())
      confirmBottomSheet(
        Strings.WARNING.tr,
        Strings.STORAGE_PERMISSION.tr,
        () {
          Get.back();
          Timer(Duration(milliseconds: 200), () {
            storagePermission();
          });
        },
        Strings.YES.tr,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 64.0,
                  ),
                  child: Image.asset(Images.LOGO, width: 140.0, height: 140.0),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      Strings.MESS_WELCOME.tr,
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 32.0)),
                AppButton(
                  title: Strings.HAVE_ALREADY_WALL.tr,
                  btnColor: Colors.white,
                  onTap: () {
                    navigateToPage(ImportWallet());
                  },
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
                AppButton(
                  title: Strings.NEW_WALLET.tr,
                  btnColor: Get.theme.primaryColor,
                  onTap: () {
                    navigateToPage(Backup());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
