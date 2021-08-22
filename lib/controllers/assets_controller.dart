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

  Rx<bool> isLoading = true.obs;

  RxList<AssetModel> assets = <AssetModel>[].obs;
  RxList<AssetModel> nfts = <AssetModel>[].obs;

  RxList<AddressModel> _coinsAddress = <AddressModel>[].obs;
  AppGet _wallet = AppGet.appGet;

  @override
  void onInit() {
    super.onInit();
    if (_wallet.walletModel!.addresses == null)
      _getAddressesAndAssets();
    else {
      for (AddressModel am in _wallet.walletModel!.addresses!)
        _coinsAddress.add(am);
      _prepareData();
    }
  }

  void _getAddressesAndAssets() async {
    AddressModel tempAddress;
    List<AssetModel> tempAssets = [];
    AssetModel tempAsset;
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
            standard: 'ERC20',
          ),
        );
      } else {
        tempAsset = await getContractDetail(
          BlockChains.ETHEREUM,
          Networks.MAIN_NET,
          b.contract!,
        );
        tempAsset.balance = b.balance;
        tempAssets.add(tempAsset);
      }

    tempAddress = AddressModel(
      address: address.toString(),
      blockChain: BlockChains.ETHEREUM,
      network: Networks.MAIN_NET,
      assets: tempAssets,
    );
    _coinsAddress.add(tempAddress);

    _prepareData();

    _wallet.walletModel!.addresses = _coinsAddress;
    _wallet.walletModel!.save();
  }

  void _prepareData(){

    for(AssetModel a in _coinsAddress[0].assets!)
      if(a.standard == 'ERC20')
        assets.add(a);
      else
        nfts.add(a);

    isLoading.value = false;
  }
}
