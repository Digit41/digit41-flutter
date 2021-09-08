import 'dart:async';

import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/models/trx_model.dart';
import 'package:digit41/pages/wallet/bottom_sheet_operations_coin.dart';
import 'package:digit41/rest_full_apis/wallet_api.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_cache_image.dart';
import 'package:digit41/widgets/app_empty_data.dart';
import 'package:digit41/widgets/app_error_again.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinDetails extends StatefulWidget {
  int index;

  CoinDetails(this.index);

  @override
  _CoinDetailsState createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  bool positive = true;
  AssetsController _assetsController = AssetsController.assetsController;
  bool refreshAgain = false;
  List<TrxModel>? trxList;
  bool update = true;

  Widget infoItem(String title, String sub) => Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(title),
          const SizedBox(height: 4.0),
          Text(
            sub,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
        ],
      );

  Widget info() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _assetsController.assets[widget.index].name!,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '\$ ${_assetsController.assets[widget.index].price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: positive ? Get.theme.primaryColor : Colors.red,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    positive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: positive ? Get.theme.primaryColor : Colors.red,
                    size: 18.0,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: infoItem(
              Strings.BALANCE.tr,
              '${_assetsController.assets[widget.index].balance!.toStringAsPrecision(_assetsController.assets[widget.index].precision!)}',
            ),
          ),
          infoItem(
            Strings.VALUE.tr,
            '\$ ${_assetsController.assets[widget.index].balanceInPrice!.toStringAsFixed(2)}',
          ),
        ],
      );

  Widget bottom() => Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        height: 92.0,
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
                // FloatingActionButton(
                //   heroTag: 'share',
                //   backgroundColor: AppTheme.gray,
                //   onPressed: () {},
                //   child: Image.asset(
                //     Images.SHARE,
                //     color: Colors.white,
                //     width: 25.0,
                //     height: 25.0,
                //   ),
                // ),
                // const SizedBox(height: 8.0),
                // Text(
                //   Strings.SHARE.tr,
                //   style: TextStyle(
                //     fontWeight: FontWeight.w500,
                //     color: AppTheme.gray,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );

  void getTrxList({String forceUp = 'false'}) {
    if (refreshAgain)
      setState(() {
        refreshAgain = false;
      });
    getTrxs(
      _assetsController.coinsAddress[0].blockChain!,
      _assetsController.coinsAddress[0].network!,
      _assetsController.coinsAddress[0].address!,
      contract: _assetsController.assets[widget.index].contract,
      forceUpdate: forceUp,
    ).then((value) {
      setState(() {
        trxList = value;
      });

      /// for updating and fetch trxList form root if trxList is empty
      if(trxList!.isEmpty && update){
        update = false;
        getTrxList(forceUp: 'true');
      }
    }).catchError((e) {
      setState(() {
        refreshAgain = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    positive = _assetsController.assets[widget.index].percentChange24h! > 0;
    getTrxList();
  }

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
                Text(
                  _assetsController.assets[widget.index].contract == null
                      ? Strings.COIN.tr
                      : Strings.TOKEN.tr,
                ),
                const SizedBox(height: 16.0),
                CacheImage(
                  _assetsController.assets[widget.index].icon!,
                  size: 90.0,
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: info(),
                ),
                Expanded(
                  child: refreshAgain
                      ? AppErrorAgain(onReloadButtonTap: getTrxList)
                      : trxList == null
                          ? CupertinoActivityIndicator()
                          : trxList!.isEmpty
                              ? AppEmptyData()
                              : RefreshIndicator(
                                  onRefresh: () async {
                                    getTrxList(forceUp: 'true');
                                    await Future.delayed(Duration(seconds: 3));
                                  },
                                  child: ListView.builder(
                                    itemBuilder: item,
                                    itemCount: trxList!.length,
                                  ),
                                ),
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
        padding: EdgeInsets.only(
          bottom: index == trxList!.length - 1 ? 96.0 : 0.0,
        ),
        child: ListTile(
          onTap: () {
            trxDetailsBottomSheet(
              context,
              trxList![index],
              _assetsController.assets[widget.index],
            );
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
            child: Text('DateTime'),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trxList![index].amount!.toStringAsPrecision(
                      _assetsController.assets[widget.index].precision!,
                    ),
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
