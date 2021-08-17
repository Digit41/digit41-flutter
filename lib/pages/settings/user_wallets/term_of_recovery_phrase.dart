import 'package:digit41/pages/settings/user_wallets/show_recovery_phrases.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void termOfRecPhrase(String mnemonic) {
  Widget terms(String term) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.red,
              ),
              margin: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 0.0),
            ),
            Flexible(child: Text(term)),
          ],
        ),
      );
  bottomSheet(
    Strings.RECOVERY_PHRASE.tr,
    child: Column(
      children: [
        Image.asset(Images.LOGO, width: 250.0, height: 250.0),
        const SizedBox(height: 32.0),
        terms(Strings.CON1_REC_PH.tr),
        terms(Strings.CON2_REC_PH.tr),
        terms(Strings.CON3_REC_PH.tr),
        const SizedBox(height: 16.0),
        AppCheckbox(
          Strings.I_UNDERSTAND.tr,
          AppButton(
            title: Strings.CONTINUE.tr,
            btnColor: Get.theme.primaryColor,
            onTap: () {
              navigateToPage(ShowRecoveryPhrases(mnemonic));
            },
          ),
        ),
      ],
    ),
  );
}
