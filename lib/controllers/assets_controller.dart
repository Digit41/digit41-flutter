import 'package:digit41/app_web3/addresses.dart';
import 'package:digit41/app_web3/utils.dart';
import 'package:digit41/models/address_model.dart';
import 'package:digit41/models/asset_model.dart';
import 'package:digit41/models/balance_model.dart';
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
    List<AssetModel> tempAssets = [];
    List<BalanceModel> tempBalanceList;

    /// now, just for Ethereum
    EthereumAddress address = await getCoinPublicAddress(
      Coins.Ethereum,
      _wallet.walletModel!.mnemonic,
      0,
    );

    tempBalanceList = await getBalances(
      BlockChains.ETHEREUM,
      Networks.MAIN_NET,
      address.toString(),
    );

    for (BalanceModel b in tempBalanceList)
      if (b.contract == null) {
        tempAssets.add(
          AssetModel(
            name: 'Ethereum',
            balance: b.balance,
            icon: 'https://s4.uupload.ir/files/ethereum-eth-icon_w0jo.png',
          ),
        );
      }

    tempAddress = AddressModel(
      address: address.toString(),
      blockChain: BlockChains.ETHEREUM,
      network: Networks.MAIN_NET,
      assets: tempAssets,
    );
    coinsAddress.add(tempAddress);

    // _wallet.walletModel!.addresses = [tempAddress];
    // _wallet.walletModel!.save();
  }
}
