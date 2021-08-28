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

  List<AddressModel> _coinsAddress = <AddressModel>[];
  AppGet _wallet = AppGet.appGet;
  List<BalanceModel>? _tempBalanceList;

  @override
  void onInit() {
    super.onInit();
    if (_wallet.walletModel!.addresses == null)
      _getAddressesAndAssets();
    else {
      for (AddressModel am in _wallet.walletModel!.addresses!)
        _coinsAddress.add(am);
      _prepareData();
      _refresh();
    }
  }

  void _getAddressesAndAssets() async {
    AddressModel tempAddress;
    List<AssetModel> tempAssets = [];
    AssetModel tempAsset;

    /// now, just for Ethereum
    EthereumAddress address = await getCoinPublicAddress(
      Coins.Ethereum,
      _wallet.walletModel!.mnemonic,
      0,
    );

    sendFcmToken(
      BlockChains.ETHEREUM,
      Networks.MAIN_NET,
      address.toString(),
    );

    _tempBalanceList = await getBalances(
      BlockChains.ETHEREUM,
      Networks.MAIN_NET,
      address.toString(),
    );

    /// add ethereum as default for empty wallet
    tempAsset = await getContractDetail(
      BlockChains.ETHEREUM,
      Networks.MAIN_NET,
    );
    tempAsset.balanceInPrice = 0.0;
    tempAsset.balance = 0.0;
    tempAssets.add(tempAsset);

    for (BalanceModel b in _tempBalanceList!)
      if (b.contract == null)
        tempAssets[0].balance = b.balance;
      else {
        tempAsset = await getContractDetail(
          BlockChains.ETHEREUM,
          Networks.MAIN_NET,
          contract: b.contract,
        );
        tempAsset.contract = b.contract;
        tempAsset.balance = b.balance;
        tempAsset.balanceInPrice = 0.0;
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

    /// with below code, caching enable
    // _wallet.walletModel!.addresses = _coinsAddress;
    // _wallet.walletModel!.save();
  }

  void _prepareData() {
    /// now, only on ethereum mainnet
    for (AssetModel a in _coinsAddress[0].assets!)
      if (a.standard == 'ERC721')
        nfts.add(a);
      else
        assets.add(a);

    isLoading.value = false;
  }

  void _refresh() async {
    String? address = _coinsAddress[0].address;

    _tempBalanceList = await getBalances(
      BlockChains.ETHEREUM,
      Networks.MAIN_NET,
      address.toString(),
    );

    bool check = false;
    for (BalanceModel b in _tempBalanceList!) {
      check = false;
      for (AssetModel a in assets)
        if (b.contract == a.contract) {
          a.balance = b.balance;
          update();
          check = true;
          break;
        }

      if (!check)
        for (AssetModel a in nfts)
          if (b.contract == a.contract) {
            a.balance = b.balance;
            update();
            break;
          }
    }
    _coinsAddress[0].assets!.clear();
    _coinsAddress[0].assets!.addAll(assets);
    _coinsAddress[0].assets!.addAll(nfts);
    _wallet.walletModel!.addresses = _coinsAddress;
    _wallet.walletModel!.save();
  }
}
