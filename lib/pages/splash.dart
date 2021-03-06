import 'dart:async';

import 'package:digit41/controllers/network_controller.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/pages/welcome.dart';
import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/initializing.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'with_confirmation.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  WalletController walletCtl = WalletController.walletCtl;
  bool exist = false;

  Future<void> initNetwork() async {
    await initHiveNetwork();

    /// init default network
    NetworkController.netCtl.initDefaultNetwork();
  }

  Future<void> checkExistActiveWallet() async {
    /// init default network
    await walletCtl.setWalletModel();
    if (walletCtl.walletModel != null) exist = true;
  }

  void go() async {
    await initNetwork();
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
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.SPLASH_LOGO,
              height: 200.0,
              width: 200.0,
            ),
            const SizedBox(height: 24.0),
            const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
