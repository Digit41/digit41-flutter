import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:digit41/app_web3/utils.dart';
import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/controllers/network_controller.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/models/asset_model.dart';
import 'package:digit41/models/trx_model.dart';
import 'package:digit41/utils/app_snackbar.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_cache_image.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

part 'receipt.dart';
part 'send.dart';
part 'trx_detail.dart';

Widget _buttonIcon(String path, {Color? color}) => Image.asset(
  path,
  width: 25.0,
  height: 25.0,
  color: Colors.white,
);

void _coinOperationsBottomSheet(BuildContext context, String icon, Widget child,
    {bool send = true, bool trxDetail = false}) {
  Get.bottomSheet(
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50.0),
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 44.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(24.0),
              topLeft: const Radius.circular(24.0),
            ),
            color: Get.theme.bottomSheetTheme.backgroundColor,
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: child,
          ),
        ),
        Positioned(
          top: 0.0,
          left: MediaQuery.of(context).size.width / 2 - 45.0,
          child: Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(8.0),
            width: 85.0,
            height: 85.0,
            decoration: trxDetail
                ? BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: Get.theme.primaryColor,
              ),
              borderRadius: BorderRadius.circular(50.0),
            )
                : null,
            child: CacheImage(icon),
          ),
        ),
        if (!trxDetail)
          Positioned(
            left: MediaQuery.of(context).size.width / 2 + 10.0,
            top: 2.0,
            width: 35.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Get.theme.primaryColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Icon(
                send ? Icons.arrow_upward : Icons.arrow_downward,
                color: AppTheme.gray,
              ),
            ),
          ),
      ],
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}
