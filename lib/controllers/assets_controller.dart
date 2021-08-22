import 'package:digit41/app_web3/addresses.dart';
import 'package:digit41/app_web3/utils.dart';
import 'package:digit41/models/address_model.dart';
import 'package:digit41/rest_full_apis/wallet_api.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

class AssetsController extends GetxController {
  static AssetsController get assetsController => Get.put(AssetsController());

  RxList<AddressModel> coinsAddress = <AddressModel>[].obs;

  AppGet _wallet = AppGet.appGet;

  @override
  void onInit() {
    super.onInit();
    if (_wallet.walletModel!.addresses == null)
      _getAddressesAndAssets();
    else
      for (AddressModel am in _wallet.walletModel!.addresses!)
        coinsAddress.add(am);
  }

  void _getAddressesAndAssets() async {
    AddressModel tempAddress;

    /// now, just for Ethereum
    EthereumAddress address = await getCoinPublicAddress(
      Coins.Ethereum,
      _wallet.walletModel!.mnemonic,
      0,
    );
    
    await getBalances(
      BlockChains.ETHEREUM,
      Networks.MAIN_NET,
      address.toString(),
    );

    tempAddress = AddressModel(
      name: 'Ehtereum',
      address: address.toString(),
      blockChain: BlockChains.ETHEREUM,
      network: Networks.MAIN_NET,
    );

    coinsAddress.add(tempAddress);

    _wallet.walletModel!.addresses = [tempAddress];
    _wallet.walletModel!.save();
  }
}
