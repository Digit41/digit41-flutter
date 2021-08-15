import 'package:digit41/app_web3/addresses.dart';
import 'package:digit41/app_web3/supported_coins.dart';
import 'package:web3dart/credentials.dart';

Future getBalances(String mnemonic) async {
  EthereumAddress address = await getEthereumPublicAddress(
    Coins.Ehtereum,
    mnemonic,
    0,
  );

}
