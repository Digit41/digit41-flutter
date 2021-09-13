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
    if (!GetPlatform.isWeb)
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
          bottomSheetNavigateWithReplace(storagePermission);
        },
        Strings.YES.tr,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Image.asset(Images.LOGO, width: 140.0, height: 140.0),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: Text(
                  Strings.MESS_WELCOME.tr,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            AppButton(
              title: Strings.HAVE_ALREADY_WALL.tr,
              btnColor: Colors.white,
              onTap: importWallet,
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
    );
  }
}
