import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/models/network_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'assets_controller.dart';

class NetworkController extends GetxController {
  static NetworkController get netCtl => Get.put(NetworkController());

  NetworkModel? networkModel;

  Future<void> initDefaultNetwork({NetworkModel? network}) async {
    if (network == null) {
      NetworkModel temp;
      var box = await Hive.openBox(HiveKey.HIVE_NETWORK_BOX);
      for (int i = 0; i < box.length; i++) {
        temp = box.getAt(i) as NetworkModel;
        if (temp.selected) {
          networkModel = temp;
          break;
        }
      }
      box.close();
    } else
      networkModel = network;

    /// with changing network requires asset renewal
    Get.delete<AssetsController>(force: true);

    update();
  }

  /// for set default active network after delete previous active network
  Future<void> setDefaultNetwork() async {
    var box = await Hive.openBox(HiveKey.HIVE_NETWORK_BOX);
    NetworkModel nm = box.getAt(0) as NetworkModel;
    nm.selected = true;
    nm.save();
    networkModel = nm;
    box.close();

    /// changing network requires asset renewal
    Get.delete<AssetsController>(force: true);

    update();
  }
}
