import 'dart:async';

import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/models/network_model.dart';
import 'package:digit41/pages/settings/any_item.dart';
import 'package:digit41/pages/settings/networks/network.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/fab_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

Box? _box;

Future<List<NetworkModel>> _getNetworks() async {
  List<NetworkModel> nList = [];
  _box = await Hive.openBox(HiveKey.HIVE_NETWORK_BOX);
  for (int i = 0; i < _box!.length; i++) nList.add(_box!.getAt(i));
  return nList;
}

void networks() {
  List<NetworkModel> netList;
  int selectedIndex = 0;

  bottomSheet(
    Strings.NETWORKS.tr,
    child: FutureBuilder(
      future: _getNetworks(),
      builder: (ctx, snapData) {
        if (snapData.hasData) {
          netList = snapData.data as List<NetworkModel>;
          return SizedBox(
            /// adjust the height to expand the display list according to the content
            /// means --> 52.0 * netList.length
            /// and also above value + with 100.0 for stay on fab below of list
            height: 52.0 * netList.length + 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: netList.length,
                    itemBuilder: (ctx, int index) {
                      if (netList[index].selected) selectedIndex = index;
                      return anyItemOfWalletAndNetwork(
                        netList[index].name!,
                        netList[index].selected,
                        onTap: () {
                          if (!netList[index].selected) {
                            netList[index].selected = true;
                            netList[index].save();
                            netList[selectedIndex].selected = false;

                            /// There may be no selected network
                            try {
                              netList[selectedIndex].selected = false;
                              netList[selectedIndex].save();
                            } catch (e) {}

                            _box!.close();
                          }
                          Get.back();
                        },
                        trailing: IconButton(
                          onPressed: () {
                            bottomSheetNavigateWithReplace((){
                              network(_box!, netModel: netList[index]);
                            });
                          },
                          icon: Icon(
                            netList[index].byUser
                                ? Icons.edit
                                : Icons.visibility_outlined,
                            color:
                                netList[index].selected ? Colors.white : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                fabAdd(
                  Strings.ADD_NETWORK.tr,
                  onTap: () {
                    bottomSheetNavigateWithReplace((){
                      network(_box!);
                    });
                  },
                ),
              ],
            ),
          );
        } else
          return Center(child: CupertinoActivityIndicator());
      },
    ),
  );
}
