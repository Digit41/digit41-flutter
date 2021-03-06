import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/models/wallet_model.dart';
import 'package:get/get.dart';

import 'assets_controller.dart';

class WalletController extends GetxController {
  static WalletController get walletCtl => Get.put(WalletController());

  /// use for recognize active wallet
  WalletModel? walletModel;

  Future<void> setWalletModel({WalletModel? wm}) async {
    if (wm == null) {
      WalletModel temp;
      WalletHive w = WalletHive();
      var box = await w.getBox();
      for (int i = 0; i < box.length; i++) {
        temp = box.getAt(i) as WalletModel;
        if (temp.selected) {
          walletModel = temp;
          break;
        }
      }
    } else
      walletModel = wm;

    /// with Adding or changing wallets requires asset renewal
    Get.delete<AssetsController>(force: true);

    update();
  }

  // /// for set default active network after delete previous active network
  // Future<void> setDefaultWallet() async {

  //   /// with Adding or changing wallets requires asset renewal
  //   // Get.delete<AssetsController>(force: true);
  //
  //   update();
  // }

  void forUpdateUI() {
    update();
  }
}