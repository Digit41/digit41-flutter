import 'dart:convert';

import 'package:hive/hive.dart';

import 'wallet_model.dart';

class AppHive {
  Box? box;

  Future<List<int>> _key() async {
    /**
        encrypt hive boxes
        Hive supports AES-256 box data encryption.
        To create a 256-bit key, we can use the built-in function
     */

    /**
        When you close the application,
        you can store the key using the flutter_secure_storage package.

        so using flutter secure storage for saving encryptionKey
     */
    List<int> secureList;
    // FlutterSecureStorage secureStorage = FlutterSecureStorage();
    // String key = await secureStorage.read(key: SecureKey.HIVE_KEY);
    // FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? key; //= await secureStorage.read(key: SecureKey.HIVE_KEY);
    if (key == null) {
      secureList = Hive.generateSecureKey();
      // await secureStorage.write(
      //   key: SecureKey.HIVE_KEY,
      //   value: secureList.toString(),
      // );
    } else

      /// json decode return dynamic type, its necessary casting
      secureList = List<int>.from(json.decode(key));

    return secureList;
  }

  Future<Box> getBox(String boxName) async {
    return await Hive.openBox(
      boxName,
      // encryptionCipher: HiveAesCipher(await _key()),
    );
  }

  Future<WalletModel> configureWallet(String seed, {String? name}) async {
    WalletModel walletModel;
    WalletModel temp;
    box = await getBox(HiveKey.HIVE_WALLET_BOX);
    int countWall = box!.length;

    walletModel = WalletModel(
      name ?? 'Wallet ${countWall + 1}',
      seed,
      selected: true,
    );
    await box!.add(walletModel);

    /// for unSelect other wallet Except this
    for (int i = 0; i < countWall; i++) {
      temp = box!.getAt(i) as WalletModel;
      temp.selected = false;
      await temp.save();
    }

    return walletModel;
  }

  Future<List<WalletModel>> getWallets() async {
    List<WalletModel> _wallets = [];
    box = await getBox(HiveKey.HIVE_WALLET_BOX);
    for (int i = 0; i < box!.length; i++)
      _wallets.add(box!.getAt(i) as WalletModel);

    return _wallets;
  }
}

class HiveKey {
  static const HIVE_KEY = 'hiveEncryptionKey';
  static const HIVE_WALLET_BOX = 'wallet';
}
