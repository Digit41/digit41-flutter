import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/hive/wallet_model.dart';
import 'package:get/get.dart';

class AppGet extends GetxController {
  static AppGet get appGet => Get.put(AppGet());

  /// use for recognize active wallet
  WalletModel? walletModel;

  Future<void> setWalletModel({WalletModel? wm}) async {
    if (wm == null) {
      WalletModel temp;
      AppHive ah = AppHive();
      var box = await ah.getBox(SecureKey.HIVE_WALLET_BOX);
      for (int i = 0; i < box.length; i++) {
        temp = box.getAt(i) as WalletModel;
        if (temp.selected) {
          walletModel = temp;
          break;
        }
      }
      box.close();
    } else
      walletModel = wm;
    update();
  }

  void forUpdateUI(){
    update();
  }
}