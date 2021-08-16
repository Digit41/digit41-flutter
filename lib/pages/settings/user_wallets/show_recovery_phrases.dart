import 'package:clipboard/clipboard.dart';
import 'package:digit41/pages/phrases/any_phrase.dart';
import 'package:digit41/utils/app_snackbar.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/inner_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowRecoveryPhrases extends StatelessWidget {
  String mnemonic;
  List<String>? _mnemonicList;

  ShowRecoveryPhrases(this.mnemonic) {
    _mnemonicList = this.mnemonic.split(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            InnerAppbar(title: Strings.YOUR_REC_PH.tr),
            const SizedBox(height: 32.0),
            Text(Strings.DESC_YOUR_REC_PH.tr, textAlign: TextAlign.center),
            const SizedBox(height: 48.0),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (int i = 0; i < _mnemonicList!.length; i++)
                    AnyPhrase(
                      '${i + 1}.${_mnemonicList![i]}',
                      Colors.white,
                      Colors.black,
                    ),
                ],
              ),
            ),
            AppButton(
              title: Strings.COPY_PHRASES.tr,
              btnColor: AppTheme.gray,
              titleColor: Colors.white,
              onTap: () {
                FlutterClipboard.copy(mnemonic);
                showSnackBar(Strings.COPIED.tr);
              },
            ),
          ],
        ),
      ),
    );
  }
}
