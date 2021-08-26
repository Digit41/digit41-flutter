import 'dart:async';
import 'dart:io';

import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_snackbar.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class WithConfirmation extends StatefulWidget {
  bool forDisabling;

  WithConfirmation({this.forDisabling = false});

  @override
  _WithConfirmationState createState() => _WithConfirmationState();
}

class _WithConfirmationState extends State<WithConfirmation> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  AppSharedPreferences pref = AppSharedPreferences();
  LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticate() async {
    if (await auth.canCheckBiometrics) {
      bool authenticated = false;

      authenticated = await auth.authenticate(
        biometricOnly: true,
        localizedReason: Strings.LOCALIZATION_REASON.tr,
        useErrorDialogs: false,
        androidAuthStrings: AndroidAuthMessages(
          cancelButton: Strings.PIN.tr,
          biometricHint: Strings.TOUCH_SENSOR.tr,
          biometricNotRecognized: Strings.FINGER_NOT_REC.tr,
          biometricRequiredTitle: Strings.FINGER_REQ_TITLE.tr,
          biometricSuccess: Strings.FINGER_SUCCESS.tr,
          goToSettingsButton: Strings.GO_TO_SETTING.tr,
          goToSettingsDescription: Strings.GO_TO_SETTING_DESC.tr,
          signInTitle: Strings.FINGER_SIGN_TITLE.tr,
        ),
        iOSAuthStrings: IOSAuthMessages(
          cancelButton: Strings.CANCEL.tr,
          goToSettingsButton: Strings.GO_TO_SETTING.tr,
          goToSettingsDescription: Strings.GO_TO_SETTING_DESC.tr,
          lockOut: Strings.LOCK_OUT.tr,
        ),
      );

      if (authenticated) navigateToPage(BottomNavigation(), popAll: true);
    }
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () async {
      if (!widget.forDisabling && !GetPlatform.isWeb)
        authenticate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PasscodeScreen(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            Strings.ENTER_PASS.tr,
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
          if (await pref.getPasscode() == enteredPassCode.hashCode.toString()) {
            if (!widget.forDisabling)
              _verificationNotifier.add(true);
            else

              /// disabling done successfully
              pref.setPasscode(null);
            Get.back(result: true);
          } else {
            // if (await Vibration.hasVibrator()) {
            //   Vibration.vibrate();
            // }

            _verificationNotifier.add(false);
            showSnackBar(Strings.INVALID_PASS.tr);
            return;
          }
        },
        isValidCallback: () {
          navigateToPage(BottomNavigation(), replace: true);
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
          if (!widget.forDisabling) {
            if (GetPlatform.isIOS)
              exit(0);
            else
              SystemNavigator.pop();
          } else
            Get.back();
        },
      ),
    );
  }
}
