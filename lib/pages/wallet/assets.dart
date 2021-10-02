import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/pages/wallet/coin_details.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Assets extends StatelessWidget {
  bool positive = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AssetsController controller) {
        if (controller.isLoading)
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
            itemBuilder: (ctx, index) {
              if (controller.assets[index].percentChange24h != null)
                positive = controller.assets[index].percentChange24h! > 0;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == controller.assets.length - 1 ? 80.0 : 0.0,
                  top: 2.0,
                ),
                child: ListTile(
                  onTap: () {
                    navigateToPage(CoinDetails(index));
                  },
                  leading: CacheImage(
                    controller.assets[index].icon ?? '',
                    size: 46.0,
                  ),
                  title: Text(
                    '${controller.assets[index].balance!.toStringAsPrecision((controller.assets[index].precision ?? 4))} ' +
                        '${controller.assets[index].symbol}',
                  ),
                  subtitle: Text(
                    '\$ ${controller.assets[index].balanceInPrice!.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: darkModeEnabled() ? Colors.grey : AppTheme.gray,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$ ${controller.assets[index].price!.toStringAsFixed(2)}',
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            positive
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color:
                                positive ? Get.theme.primaryColor : Colors.red,
                            size: 18.0,
                          ),
                          Text(
                            '${controller.assets[index].percentChange24h!.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: positive
                                  ? Get.theme.primaryColor
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
      },
    );
  }
}
