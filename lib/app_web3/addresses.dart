import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

import 'supported_coins.dart';

Future<EthereumAddress> getEthereumPublicAddress(
    Coins coin,
    String mnemonic,
    int index,
    ) async {
  if (coin != Coins.Ehtereum) if (coin != Coins.EthereumClassic) {
    if (coin != Coins.VeChain)
      throw ArgumentError("only ethereum, ethereumClassic and Vechain");
  }

  String privateKey = getCoinPrivateKeyThatWIFNotSupported(
    coin,
    mnemonic,
    index,
  );
  Credentials private = EthPrivateKey.fromHex(privateKey);

  final address = await private.extractAddress();

  return address;
}

String getCoinPrivateKeyThatWIFNotSupported(
    Coins coin,
    String mnemonic,
    int index,
    ) {
  final seed = bip39.mnemonicToSeed(mnemonic);
  final root = bip32.BIP32.fromSeed(seed);

  bip32.BIP32 node;
  if (Coins.Ehtereum == coin)
    node = root.derivePath("m/44'/60'/0'/0/$index");
  else if (Coins.Tron == coin)
    node = root.derivePath("m/44'/195'/0'/0/$index");
  else if (Coins.EthereumClassic == coin)
    node = root.derivePath("m/44'/61'/0'/0/$index");
  else if (Coins.VeChain == coin)
    node = root.derivePath("m/44'/818'/0'/0/$index");
  else if (Coins.Ripple == coin)
    node = root.derivePath("m/44'/144'/0'/0/$index");
  else
    throw ArgumentError("Coins path not exist");

  return HEX.encode(node.privateKey!.toList());
}