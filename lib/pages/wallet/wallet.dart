import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/pages/wallet/assets.dart';
import 'package:digit41/pages/wallet/nfts.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int selectedTab = 0;
  AppGet appGet = AppGet.appGet;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: ListView(
        children: [
          Container(
            height: 290.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: darkModeEnabled()
                  ? DecorationImage(
                      image: AssetImage(Images.BACKGROUND),
                      fit: BoxFit.cover,
                    )
                  : null,
              gradient: darkModeEnabled()
                  ? null
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        const Color(0xFFccefb5),
                        const Color(0xFFaddcfd),
                        const Color(0xFFdeb9f9),
                        const Color(0xFFdeb9f9),
                      ],
                    ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32.0),
                Text(
                  appGet.walletModel!.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32.0),
                Text(
                  Strings.ASSETS_VALUE.tr,
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                ),
                const SizedBox(height: 32.0),
                GetBuilder(
                  init: AssetsController(),
                  builder: (AssetsController controller) => controller.isLoading
                      ? Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: CupertinoActivityIndicator(),
                      )
                      : Text(
                          '\$ ${controller.totalAssets[0].toStringAsFixed(3)}',
                          style: TextStyle(
                            fontSize: 52.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 30.0),
                TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  indicatorColor:
                      darkModeEnabled() ? Get.theme.primaryColor : Colors.black,
                  labelColor:
                      darkModeEnabled() ? Get.theme.primaryColor : Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 3.0,
                  labelPadding: const EdgeInsets.only(bottom: 12.0),
                  indicatorPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  tabs: [
                    Text(Strings.ASSETS.tr, style: TextStyle(fontSize: 20.0)),
                    Text(Strings.NFTS.tr, style: TextStyle(fontSize: 20.0)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: selectedTab == 0 ? Assets() : NFTs(),
          ),
        ],
      ),
    );
  }
}
