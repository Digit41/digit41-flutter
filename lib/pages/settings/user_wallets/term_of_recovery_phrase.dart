import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_checkbox.dart';
import 'package:digit41/widgets/inner_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermOfRecPhrase extends StatefulWidget {
  @override
  _TermOfRecPhraseState createState() => _TermOfRecPhraseState();
}

class _TermOfRecPhraseState extends State<TermOfRecPhrase> {
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
              margin: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
            ),
            Flexible(child: Text(term)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24.0),
                    InnerAppbar(title: Strings.RECOVERY_PHRASE.tr),
                    const SizedBox(height: 32.0),
                    Image.asset(Images.LOGO, width: 300.0, height: 300.0),
                    const SizedBox(height: 48.0),
                    terms(Strings.CON1_REC_PH.tr),
                    terms(Strings.CON2_REC_PH.tr),
                    terms(Strings.CON3_REC_PH.tr),
                  ],
                ),
              ),
            ),
            AppCheckbox(
              Strings.I_UNDERSTAND.tr,
              AppButton(
                title: Strings.CONTINUE.tr,
                btnColor: Get.theme.primaryColor,
                onTap: () {
                  // navigateToPage(Phrases());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
