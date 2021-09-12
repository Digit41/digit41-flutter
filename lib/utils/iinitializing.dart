import 'package:digit41/hive/app_hive.dart';
import 'package:digit41/models/network_model.dart';
import 'package:hive/hive.dart';

final _networks = [
  NetworkModel(name: 'Ethereum Mainnet', url: 'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161', selected: true),
  NetworkModel(name: 'Rinkeby Test Network', url: 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'),
  NetworkModel(name: 'Binance Smart Chain Mainnet', url: 'https://bsc-dataseed1.binance.org'),
];


void initHiveNetwork() async{
  Box box = await Hive.openBox(HiveKey.HIVE_NETWORK_BOX);
  if(box.length == 0)
    for(NetworkModel nm in _networks)
      box.add(nm);
  box.close();
}