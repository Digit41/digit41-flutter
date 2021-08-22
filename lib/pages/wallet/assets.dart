import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/pages/wallet/coin_details.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_cache_image.dart';
import 'package:digit41/widgets/app_empty_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Assets extends StatelessWidget {
  AssetsController _assetsController = AssetsController.assetsController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_assetsController.isLoading.value)
        return Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: CupertinoActivityIndicator(),
        );
      else {
        return _assetsController.assets.length == 0
            ? AppEmptyData()
            : ListView.builder(
                itemCount: _assetsController.assets.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: index == _assetsController.assets.length - 1
                        ? 80.0
                        : 0.0,
                    top: 12.0,
                  ),
                  child: ListTile(
                    onTap: () {
                      navigateToPage(CoinDetails());
                    },
                    leading:
                        CacheImage(_assetsController.assets[index].icon ?? ''),
                    title: Text(_assetsController.assets[index].name!),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$ 3,221',
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                        Icon(
                          Icons.arrow_drop_up,
                          color: Get.theme.primaryColor,
                          size: 18.0,
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${_assetsController.assets[index].balance} ETH'),
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
              );
      }
    });
  }
}
