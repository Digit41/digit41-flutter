import 'dart:async';

import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:get/get.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void createAccount() {
  WalletController walletCtl = WalletController.walletCtl;
  final formKey = GlobalKey<FormState>();
  AppTextFormField name = AppTextFormField(
    hint: Strings.ACCOUNT.tr + ' ' + Strings.NAME.tr,
  );
  name.controller.text = Strings.ACCOUNT.tr +
      ' ' +
      (walletCtl.walletModel!.selectedAddressIndex + 2).toString();
  bool create = false;

  bottomSheet(
    Strings.CREATE.tr + ' ' + Strings.ACCOUNT.tr,
    child: Column(
      children: [
        const SizedBox(height: 16.0),
        Form(key: formKey, child: name),
        const SizedBox(height: 16.0),
        StatefulBuilder(
          builder: (context, setState) => create
              ? CupertinoActivityIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton1(
                        title: Strings.CREATE.tr,
                        btnColor: Get.theme.primaryColor,
                        titleColor: Colors.black,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              create = true;
                            });
                            Timer(Duration(milliseconds: 100), () async {
                              walletCtl.walletModel!.selectedAddressIndex++;
                              await AssetsController.assetsController.init(
                                name.controller.text,
                                addressIndex:
                                    walletCtl.walletModel!.selectedAddressIndex,
                              );
                              walletCtl.forUpdateUI();
                              Get.back();
                            });
                          }
                        },
                        icon: Center(),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    Expanded(
                      child: AppButton1(
                        title: Strings.CANCEL.tr,
                        onTap: () {
                          Get.back();
                        },
                        icon: Center(),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    ),
  );
}
