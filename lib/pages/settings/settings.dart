import 'package:digit41/controllers/network_controller.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/pages/settings/accounts/accounts.dart';
import 'package:digit41/pages/settings/currency.dart';
import 'package:digit41/pages/settings/languages.dart';
import 'package:digit41/pages/settings/networks/networks.dart';
import 'package:digit41/rest_full_apis/routes.dart';
import 'package:digit41/utils/app_shared_preferences.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../with_confirmation.dart';
import 'my_pass_code.dart';
import 'user_wallets/user_wallets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  WalletController walletCtl = WalletController.walletCtl;
  AppSharedPreferences pref = AppSharedPreferences();
  bool? enableDark;
  String? pass;
  String? currencyKey;

  bool notif = true;

  Future<bool> init() async {
    pass = await pref.getPasscode();

    currencyKey = await pref.getCurrencyKey();

    if (currencyKey == null) currencyKey = 'USD';

    return true;
  }

  @override
  void initState() {
    super.initState();
    enableDark = darkModeEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 32.0),
          Text(
            Strings.SETTING_CAP.tr,
            style: TextStyle(color: Colors.grey, fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          item(
            Images.WHITE_WALLET,
            Strings.WALLETS.tr,
            onTap: userWallets,
            trailing: GetBuilder(
              init: WalletController(),
              builder: (ctx) => Text(
                walletCtl.walletModel!.name,
              ),
            ),
          ),
          item(
            Images.WHITE_WALLET,
            Strings.ACCOUNTS.tr,
            onTap: accounts,
            trailing: GetBuilder(
              init: WalletController(),
              builder: (ctx) => Text(
                walletCtl
                    .walletModel!
                    .addresses![walletCtl.walletModel!.selectedAddressIndex]
                    .name,
              ),
            ),
          ),
          item(
            Images.NETWORK,
            Strings.NETWORKS.tr,
            onTap: networks,
            trailing: GetBuilder(
              init: NetworkController(),
              builder: (ctx) => Text(
                NetworkController.netCtl.networkModel!.name!,
                style: TextStyle(
                  fontSize:
                      NetworkController.netCtl.networkModel!.name!.length > 26
                          ? 10.0
                          : 14.0,
                ),
              ),
            ),
          ),
          passcode(),
          item(
            Images.CURRENCY,
            Strings.CURRENCY.tr,
            trailing: GetBuilder(
              init: WalletController(),
              builder: (ctx) => FutureBuilder(
                future: init(),
                builder: (ctx, snapData) {
                  if (snapData.hasData)
                    return Text(currencyKey!);
                  else
                    return CupertinoActivityIndicator();
                },
              ),
            ),
            onTap: () {
              currencyBottomSheet(currencyKey!);
            },
          ),
          item(
            Images.LANGUAGES,
            Strings.LANGUAGE.tr,
            trailing: Text(Strings.CURRENT_LAN.tr),
            onTap: languagesBottomSheet,
          ),
          item(
            Images.SWITCH,
            Strings.DARK_MODE.tr,
            trailing: Text(enableDark! ? Strings.ON.tr : Strings.OFF.tr),
            onTap: themeOnTap,
          ),
          item(
            Images.NOTIFICATION,
            Strings.NOTIFICATIONS.tr,
            trailing: Text(notif ? Strings.ON.tr : Strings.OFF.tr),
            onTap: () {
              setState(() {
                notif = !notif;
              });
            },
          ),
          const SizedBox(height: 32.0),
          Text(
            Strings.COMMUNITY.tr,
            style: TextStyle(color: Colors.grey, fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          item(Images.TWITTER, Strings.TWITTER.tr, onTap: () {
            launchURL(Routes.TWITTER);
          }),
          item(Images.TELEGRAM, Strings.TELEGRAM.tr, onTap: () {
            launchURL(Routes.TELEGRAM);
          }),
          item(Images.EARTH_HOME, Strings.ABOUT_US.tr),
          const SizedBox(height: 72.0),
        ],
      ),
    );
  }

  Widget item(String image, String title,
          {Widget? trailing, GestureTapCallback? onTap}) =>
      ListTile(
        onTap: onTap,
        leading: Image.asset(
          image,
          width: 28.0,
          height: 28.0,
          color: enableDark! ? Colors.white : Colors.black,
        ),
        title: Text(title),
        trailing: trailing,
      );

  void themeOnTap() {
    if (darkModeEnabled()) {
      Get.changeTheme(AppTheme.light);
      Get.changeThemeMode(ThemeMode.light);
      pref.setTheme('light');
    } else {
      Get.changeTheme(AppTheme.dark);
      Get.changeThemeMode(ThemeMode.dark);
      pref.setTheme('dark');
    }
    setState(() {
      enableDark = !enableDark!;
    });
  }

  Widget passcode() => item(
        Images.SECURITY,
        Strings.PASSCODE.tr,
        onTap: () async {
          if (pass == null)
            navigateToPage(MyPassCode(Strings.ENTER_NEW_PASS.tr));
          else {
            await navigateToPage(WithConfirmation(forDisabling: true));
            setState(() {});
          }
        },
        trailing: GetBuilder(
          init: WalletController(),
          builder: (ctx) => FutureBuilder(
            future: init(),
            builder: (ctx, snapData) {
              if (snapData.hasData)
                return Text(pass != null ? Strings.ON.tr : Strings.OFF.tr);
              else
                return CupertinoActivityIndicator();
            },
          ),
        ),
      );
}
