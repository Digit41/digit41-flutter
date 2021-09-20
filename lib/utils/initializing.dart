import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/models/network_model.dart';
import 'package:hive/hive.dart';

final _defaultNetworks = [
  NetworkModel(
    name: 'Ethereum Mainnet',
    url: 'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
    chainId: 1,
    currencySymbol: 'ETH',
    blockExplorerURL: 'https://etherscan.io',
    selected: true,
  ),
  NetworkModel(
    name: 'Rinkeby Test Network',
    url: 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
    chainId: 4,
    currencySymbol: 'ETH',
    blockExplorerURL: 'https://rinkeby.etherscan.io',
  ),
  NetworkModel(
    name: 'Binance Smart Chain Mainnet',
    url: 'https://bsc-dataseed1.binance.org',
    chainId: 56,
    currencySymbol: 'BNB',
    blockExplorerURL: 'https://bscscan.com',
  ),
];

void initHiveNetwork() async {
  Box box = await Hive.openBox(HiveKey.HIVE_NETWORK_BOX);
  if (box.length == 0) for (NetworkModel nm in _defaultNetworks) box.add(nm);
  box.close();
}
