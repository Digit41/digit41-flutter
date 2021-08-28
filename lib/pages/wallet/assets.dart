import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/pages/wallet/coin_details.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Assets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AssetsController(),
      builder: (AssetsController controller) {
        if (controller.isLoading.value)
          return Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: CupertinoActivityIndicator(),
          );
        else
          return ListView.builder(
            itemCount: controller.assets.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) => Padding(
              padding: EdgeInsets.only(
                bottom: index == controller.assets.length - 1 ? 80.0 : 0.0,
                top: 12.0,
              ),
              child: ListTile(
                onTap: () {
                  navigateToPage(CoinDetails());
                },
                leading: CacheImage(controller.assets[index].icon ?? ''),
                title: Text(controller.assets[index].name!),
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
                    Text(
                      '${controller.assets[index].balance} ${controller.assets[index].symbol}',
                    ),
                    Text(
                      '\$ ${controller.assets[index].balanceInPrice}',
                      style: TextStyle(
                        color: darkModeEnabled() ? Colors.grey : AppTheme.gray,
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          );
      },
    );
  }
}
