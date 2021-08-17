import 'package:clipboard/clipboard.dart';
import 'package:digit41/pages/phrases/any_phrase.dart';
import 'package:digit41/utils/app_snackbar.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showRecoveryPhrases(String mnemonic) {
  List<String>? mnemonicList = mnemonic.split(' ');
  bottomSheet(
    Strings.SHOW_REC_PHRASES.tr,
    child: Column(
      children: [
        const SizedBox(height: 16.0),
        Text(Strings.DESC_YOUR_REC_PH.tr, textAlign: TextAlign.center),
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (int i = 0; i < mnemonicList.length; i++)
              AnyPhrase(
                '${i + 1}.${mnemonicList[i]}',
                Colors.white,
                Colors.black,
              ),
          ],
        ),
        const SizedBox(height: 16.0),
        AppButton(
          title: Strings.COPY_PHRASES.tr,
          btnColor: AppTheme.gray,
          titleColor: Colors.white,
          onTap: () {
            FlutterClipboard.copy(mnemonic);
            showSnackBar(Strings.COPIED.tr);
          },
        ),
        const SizedBox(height: 8.0),
      ],
    ),
  );
}
