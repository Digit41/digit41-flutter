import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/pages/wallet/coin_details.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Assets extends StatelessWidget {
  AssetsController _assetsController = AssetsController.assetsController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _assetsController.coinsAddress.length == 0
          ? Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: CupertinoActivityIndicator(),
          )
          : ListView.builder(
              itemCount: _assetsController.coinsAddress.length,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) => Padding(
                padding:
                    EdgeInsets.only(bottom: index == 9 ? 80.0 : 0.0, top: 12.0),
                child: ListTile(
                  onTap: () {
                    navigateToPage(CoinDetails());
                  },
                  leading: Image.asset(Images.LOGO),
                  title: Text(_assetsController.coinsAddress[index].name!),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$ 3,221',
                          style: TextStyle(color: Get.theme.primaryColor)),
                      Icon(
                        Icons.arrow_drop_up,
                        color: Get.theme.primaryColor,
                        size: 18.0,
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('0.2 ETH'),
                      Text(
                        '\$1,325',
                        style: TextStyle(
                          color:
                              darkModeEnabled() ? Colors.grey : AppTheme.gray,
                        ),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
    );
  }
}
