import 'dart:async';

import 'package:digit41/pages/welcome.dart';
import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'with_confirmation.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AppGet appGet = AppGet.appGet;
  bool exist = false;

  Future<void> checkExistActiveWallet() async {
    /// init set active wallet
    await appGet.setWalletModel();
    if (appGet.walletModel != null) exist = true;
  }

  void go() async {
    await checkExistActiveWallet();
    AppSharedPreferences pref = AppSharedPreferences();
    Widget page;

    if (exist) {
      /// for check go to loginWithPasscode page or not
      if (await pref.getPasscode() != null)
        page = WithConfirmation();
      else
        page = BottomNavigation();
    } else
      page = Welcome();
    navigateToPage(page, replace: true);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), go);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(Images.BACKGROUND),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
                Image.asset(Images.BACKGROUND, fit: BoxFit.fill),
              ],
            ),
            Center(
              child: Image.asset(
                Images.SPLASH_LOGO,
                height: 200.0,
                width: 200.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}