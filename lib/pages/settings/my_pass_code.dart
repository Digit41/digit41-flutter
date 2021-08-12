import 'dart:async';

import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_snackbar.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class MyPassCode extends StatefulWidget {
  String title;

  // use for check repeat validation
  String? pass;

  MyPassCode(this.title, {this.pass});

  @override
  _MyPassCodeState createState() => _MyPassCodeState();
}

class _MyPassCodeState extends State<MyPassCode> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  AppSharedPreferences pref = AppSharedPreferences();

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PasscodeScreen(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        circleUIConfig: CircleUIConfig(
          borderColor: Colors.transparent,
          fillColor: AppTheme.gray,
          circleSize: 30,
        ),
        keyboardUIConfig: KeyboardUIConfig(
          digitBorderWidth: 2,
          primaryColor: Colors.transparent,
          digitFillColor: AppTheme.gray,
        ),
        shouldTriggerVerification: _verificationNotifier.stream,
        passwordEnteredCallback: (String enteredPassCode) async {
          /// for go validation passcode repeat
          if (widget.pass == null)
            navigateToPage(
              MyPassCode(Strings.RE_ENTER_PASS.tr, pass: enteredPassCode),
              replace: true,
              withCallback: true,
            );
          else {
            /// into repeat passcode page, check this passcode enter by user with before
            if (widget.pass != enteredPassCode) {
              // if (await Vibration.hasVibrator()) {
              //   Vibration.vibrate();
              // }

              _verificationNotifier.add(false);
              showSnackBar(Strings.INVALID_REP_PASS.tr);
              return;
            } else
              _verificationNotifier.add(true);
          }
        },
        isValidCallback: () {
          /// it is call final with set correctly passcode
          pref.setPasscode(widget.pass.hashCode.toString());
          AppGet.appGet.forUpdateUI();
        },
        cancelButton: Text(
          Strings.CLOSE.tr,
          style: TextStyle(
            color: darkModeEnabled() ? Colors.white : AppTheme.gray,
          ),
        ),
        deleteButton: Text(
          Strings.DELETE.tr,
          style: TextStyle(
            color: darkModeEnabled() ? Colors.white : AppTheme.gray,
          ),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        cancelCallback: () {
          /// this is function like willPopUp
          // provider.changeValidPass(false);
          Get.back();
        },
      ),
    );
  }
}
