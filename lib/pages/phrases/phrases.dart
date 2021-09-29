import 'package:bip39/bip39.dart' as bip39;
import 'package:digit41/pages/phrases/any_phrase.dart';
import 'package:digit41/pages/phrases/verifying_phrases.dart';
import 'package:digit41/utils/app_snackbar.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Phrases extends StatelessWidget {
  String? mnemonic;
  List<String>? mnemonicList;

  @override
  Widget build(BuildContext context) {
    mnemonic = bip39.generateMnemonic();
    mnemonicList = mnemonic!.split(' ');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Text(Strings.LETS_CREATE_WALL.tr, style: TextStyle(fontSize: 26.0)),
            const SizedBox(height: 16.0),
            Text(Strings.KEEP_SAFE.tr),
            const SizedBox(height: 64.0),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for(String s in mnemonicList!)
                    AnyPhrase(s, Colors.white, Colors.black)
                ],
              ),
            ),
            AppButton(
              title: Strings.COPY_PHRASES.tr,
              btnColor: AppTheme.gray,
              titleColor: Colors.white,
              onTap: () {
                clipboardCopy(mnemonic);
                showSnackBar(Strings.COPIED.tr);
              },
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
            AppButton(
              title: Strings.PROCEED.tr,
              btnColor: Get.theme.primaryColor,
              onTap: () {
                navigateToPage(VerifyingPhrases(mnemonicList));
              },
            ),
          ],
        ),
      ),
    );
  }
}
