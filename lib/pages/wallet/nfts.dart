import 'package:digit41/controllers/assets_controller.dart';
import 'package:digit41/pages/wallet/nft_detail.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_cache_image.dart';
import 'package:digit41/widgets/app_empty_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NFTs extends StatelessWidget {
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
          return controller.nfts.length == 0
              ? AppEmptyData()
              : ListView.builder(
                  itemCount: controller.nfts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (ctx, int index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: index == controller.nfts.length - 1 ? 80.0 : 0.0,
                      top: 12.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        navigateToPage(NFTDetail());
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CacheImage(
                            controller.nfts[index].icon ?? '',
                            size: 70.0,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.nfts[index].name!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  controller.nfts[index].description ?? '',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                );
      },
    );
  }
}
