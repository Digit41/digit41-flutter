import 'dart:ui';

import 'package:digit41/pages/settings/settings.dart';
import 'package:digit41/pages/wallet/wallet.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;

  List<Widget> pages = [
    Wallet(),
    Container(),
    Container(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedPage],
          Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              margin: const EdgeInsets.only(left: 32.0, right: 32.0),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16.0,
                    offset: Offset(0.0, 6.0),
                    spreadRadius: 10.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  _bottomItems(
                    Images.WALLET,
                    Strings.WALLET.tr,
                    selectedPage == 0 ? true : false,
                    index: 0,
                  ),
                  _bottomItems(
                    Images.CONVERT,
                    Strings.SWAP.tr,
                    selectedPage == 1 ? true : false,
                    index: 1,
                  ),
                  _bottomItems(
                    Images.WEB,
                    Strings.BROWSER.tr,
                    selectedPage == 2 ? true : false,
                    index: 2,
                  ),
                  _bottomItems(
                    Images.SETTING,
                    Strings.SETTING.tr,
                    selectedPage == 3 ? true : false,
                    index: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomItems(String icon, String label, bool selected, {int? index}) =>
      Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              selectedPage = index!;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12.0),
              Image.asset(
                icon,
                width: 25.0,
                height: 25.0,
                color: selected ? Get.theme.primaryColor : Colors.grey,
              ),
              const SizedBox(height: 4.0),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Get.theme.primaryColor : Colors.grey,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 4.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                    color:
                        selected ? Get.theme.primaryColor : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topRight: const Radius.circular(4.0),
                      topLeft: const Radius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
