// import 'package:barcode_scan2/barcode_scan2.dart';
import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'strings.dart';

const APP_VERSION = '1.0.0';

const MARKETPLACE = 'googleplay';
// const MARKETPLACE = 'cafebazaar';

/// check enable dark mode or not
bool darkModeEnabled() {
  final brightness = Get.theme.brightness;
  if (brightness == Brightness.dark) return true;
  return false;
}

bool englishAppLanguage() {
  String temp = Get.locale!.languageCode;
  return temp != 'fa';
}

Future? navigateToPage(Widget page,
    {bool replace = false, bool popAll = false, bool withCallback = false}) {
  var trans = Transition.rightToLeftWithFade;
  if (replace)
    return Get.off(withCallback ? () => page : page, transition: trans);
  else if (popAll)
    return Get.offAll(withCallback ? () => page : page, transition: trans);
  else
    return Get.to(withCallback ? () => page : page, transition: trans);
}

void bottomSheetNavigateWithReplace(sheet) {
  Get.back();
  Timer(Duration(microseconds: 200), () {
    sheet();
  });
}

/*
  for scan qr and return a String
*/
Future<String> barcodeScan() async {
  try {
    var barcode = await BarcodeScanner.scan(
      options: ScanOptions(
        strings: {
          'cancel': Strings.CANCEL.tr,
          'flash_on': Strings.FLASH_ON.tr,
          'flash_off': Strings.FLASH_OFF.tr,
        },
      ),
    );
    return barcode.rawContent.toString();
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      return Strings.CAMERA_DENIED.tr;
    } else {
      return Strings.FAILED_BARCODE_SCAN.tr;
    }
  } on FormatException {
    return Strings.FAILURE_REC_BARCODE.tr;
  } catch (e) {
    return Strings.FAILED_BARCODE_SCAN.tr;
  }
}

void launchURL(url,
    {bool forceSafariVC = false, bool universalLinksOnly = false}) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: forceSafariVC,
      universalLinksOnly: universalLinksOnly,
    );
  }
}

void clipboardCopy(String? text) => Clipboard.setData(
      ClipboardData(text: text),
    );

Future<String?> clipboardPaste() async {
  var result = await Clipboard.getData('text/plain');
  return result!.text;
}
