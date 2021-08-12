import 'package:digit41/pages/wallet/bottom_sheet_operations_coin.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinDetails extends StatefulWidget {
  @override
  _CoinDetailsState createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  Widget info() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Ethereum',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$3,221',
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_up,
                    color: Get.theme.primaryColor,
                    size: 18.0,
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(Strings.AVAILABLE.tr),
              const SizedBox(height: 4.0),
              Text(
                '0.2654',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
            ],
          ),
          Text(
            '\$0.2654',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        ],
      );

  Widget bottom() => Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        height: 90.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Get.theme.scaffoldBackgroundColor,
              Get.theme.scaffoldBackgroundColor,
              Get.theme.scaffoldBackgroundColor,
              Get.theme.scaffoldBackgroundColor.withOpacity(0.9),
              Get.theme.scaffoldBackgroundColor.withOpacity(0.9),
              Get.theme.scaffoldBackgroundColor.withOpacity(0.9),
              Get.theme.scaffoldBackgroundColor.withOpacity(0.5),
              Get.theme.scaffoldBackgroundColor.withOpacity(0.0),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: 'send',
                      onPressed: () {
                        sendBottomSheet(context);
                      },
                      child: Icon(Icons.arrow_upward, color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      Strings.SEND.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: 'receive',
                      backgroundColor: AppTheme.yellow,
                      onPressed: () {
                        receiveBottomSheet(context);
                      },
                      child: Icon(Icons.arrow_downward, color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      Strings.RECEIVE.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'share',
                  backgroundColor: AppTheme.gray,
                  onPressed: () {},
                  child: Image.asset(
                    Images.SHARE,
                    color: Colors.white,
                    width: 25.0,
                    height: 25.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  Strings.SHARE.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.gray,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40.0),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(Strings.COIN.tr),
                const SizedBox(height: 16.0),
                Image.asset(Images.LOGO, width: 90.0, height: 90.0),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: info(),
                ),
                Expanded(
                  child: ListView.builder(itemBuilder: item, itemCount: 10),
                ),
              ],
            ),
            Positioned(bottom: 0.0, left: 0.0, right: 0.0, child: bottom()),
          ],
        ),
      ),
    );
  }

  Widget item(ctx, index) => Padding(
        padding: EdgeInsets.only(bottom: index == 9 ? 96.0 : 0.0),
        child: ListTile(
          onTap: () {
            trxDetailsBottomSheet(context);
          },
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.CONVERT,
                color: Get.theme.textTheme.bodyText1!.color,
                width: 20.0,
                height: 20.0,
              ),
              const SizedBox(width: 4.0),
              Text(
                Strings.CONVERT.tr,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text('2020/11/11 - 10:51:25'),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '+0.0012251',
                style: TextStyle(color: Get.theme.primaryColor),
              ),
              const SizedBox(height: 4.0),
              Text(
                Strings.SUCCESS.tr,
                style: TextStyle(color: Get.theme.primaryColor.withAlpha(90)),
              ),
            ],
          ),
        ),
      );
}
