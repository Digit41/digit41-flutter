import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/hive/wallet_model.dart';
import 'package:digit41/models/phrase_model.dart';
import 'package:digit41/pages/phrases/any_phrase.dart';
import 'package:digit41/utils/app_permission.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_navigation.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyingPhrases extends StatefulWidget {
  List<String>? mnemonicList;

  VerifyingPhrases(this.mnemonicList);

  @override
  _VerifyingPhrasesState createState() => _VerifyingPhrasesState();
}

class _VerifyingPhrasesState extends State<VerifyingPhrases> {
  bool enableButton = false;
  bool continueSelection = true;
  List<PhraseModel> phraseList = [];
  List<PhraseModel> selectedPhrases = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.mnemonicList!.length; i++)
      phraseList.add(PhraseModel(i, widget.mnemonicList![i]));
    phraseList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.0),
                    Text(
                      Strings.CONF_PHRASES.tr,
                      style: TextStyle(fontSize: 26.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(Strings.SELECT_PHRASES_RIGHT.tr),
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: Wrap(
                        children: [
                          for (int i = 0; i < selectedPhrases.length; i++)
                            AnyPhrase(
                              selectedPhrases[i].phrase,
                              i == selectedPhrases[i].id
                                  ? Get.theme.primaryColor
                                  : Colors.red,
                              Colors.white,
                            )
                        ],
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [for (PhraseModel p in phraseList) phrases(p)],
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
            Opacity(
              opacity: enableButton ? 1.0 : 0.3,
              child: AbsorbPointer(
                absorbing: !enableButton,
                child: AppButton(
                  title: Strings.PROCEED.tr,
                  btnColor: Get.theme.primaryColor,
                  borderColor: Get.theme.primaryColor,
                  onTap: finish,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
            AppButton(
              title: Strings.SKIP.tr,
              titleColor: darkModeEnabled() ? Colors.white : Colors.white,
              borderColor: darkModeEnabled() ? Colors.white : null,
              btnColor: darkModeEnabled() ? null : AppTheme.gray,
              onTap: () {
                confirmBottomSheet(
                  Strings.CONFIRMATION.tr,
                  Strings.MESS_CONF_PHRASES.tr,
                  finish,
                  Strings.YES.tr,
                  negative: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget phrases(PhraseModel phraseModel) => GestureDetector(
        onTap: () {
          setState(() {
            if (continueSelection) {
              phraseModel.selected = !phraseModel.selected;
              if (phraseModel.selected)
                selectedPhrases.add(phraseModel);
              else
                selectedPhrases.remove(phraseModel);
            } else if (phraseModel.selected) {
              phraseModel.selected = false;
              selectedPhrases.remove(phraseModel);
              if (selectedPhrases.length == 0) continueSelection = true;
            }

            for (int i = 0; i < selectedPhrases.length; i++) {
              if (i == selectedPhrases[i].id) {
                continueSelection = true;
                if (selectedPhrases.length == phraseList.length)
                  enableButton = true;
              } else {
                continueSelection = false;
                enableButton = false;
              }
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: phraseModel.selected
                ? AppTheme.gray
                : Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.grey),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 2.0),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          margin: const EdgeInsets.all(4.0),
          child: Text(
            phraseModel.phrase,
            style: TextStyle(color: phraseModel.selected ? Colors.white : null),
          ),
        ),
      );

  void finish() async {
    /**
        using hive for save any wallet into storage
     */
    bool isAllow = true;
    if(!GetPlatform.isWeb)
      isAllow = await storagePermission();
    if (isAllow) {
      AppHive ah = AppHive();
      WalletModel walletModel = await ah.configureWallet(
        widget.mnemonicList!.join(' '),
      );

      /// set active wallet
      AppGet.appGet.setWalletModel(wm: walletModel);

      navigateToPage(BottomNavigation(), popAll: true);
    }
  }
}
