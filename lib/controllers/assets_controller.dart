import 'package:digit41/app_web3/addresses.dart';
import 'package:digit41/app_web3/utils.dart';
import 'package:digit41/controllers/network_controller.dart';
import 'package:digit41/controllers/wallet_controller.dart';
import 'package:digit41/models/address_model.dart';
import 'package:digit41/models/address_private_key_model.dart';
import 'package:digit41/models/asset_model.dart';
import 'package:digit41/models/balance_model.dart';
import 'package:digit41/pages/settings/accounts/accounts.dart';
import 'package:digit41/rest_full_apis/wallet_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class AssetsController extends GetxController {
  static AssetsController get assetsController => Get.put(AssetsController());

  bool isLoading = true;

  List<AssetModel> assets = <AssetModel>[];
  List<AssetModel> nfts = <AssetModel>[];
  List<double> totalAssets = [0.0];

  List<AddressModel> coinsAddress = <AddressModel>[];
  Web3Client? ethClient;
  WalletController _wallet = WalletController.walletCtl;
  NetworkController _netCtl = NetworkController.netCtl;
  List<BalanceModel>? _tempBalanceList;
  List<AssetModel> _tempAssets = [];
  AddressModel? _tempAddress;

  @override
  void onInit() {
    super.onInit();

    ethClient = Web3Client(_netCtl.networkModel!.url!, Client());

    if (_wallet.walletModel!.addresses == null)
      init('Account 1');
    else {
      for (AddressModel am in _wallet.walletModel!.addresses!) {
        coinsAddress.add(am);
        totalAssets[0] = am.totalAssets!;
      }
      _prepareData();
      refreshAssets();
    }
  }

  Future<void> init(String accountName, {int addressIndex = 0}) async {
    AssetModel tempAsset;

    AddressPrivateKeyModel addressPrivateKeyModel =
        await _getAddressAndPrivateKey(index: addressIndex);

    sendFcmToken(
      BlockChains.ETHEREUM,
      'mainnet',
      addressPrivateKeyModel.address.toString(),
    );

    EtherAmount amount = await ethClient!.getBalance(
      addressPrivateKeyModel.address!,
    );

    /// add ethereum as default for empty wallet
    tempAsset = await getContractDetail(BlockChains.ETHEREUM, 'mainnet');
    tempAsset.balanceInPrice = 0.0;
    tempAsset.symbol = _netCtl.networkModel!.currencySymbol;
    tempAsset.balance = convertWeiToEther(amount.getInWei.toDouble());

    /// when ever call init(this function), must _tempAssets become empty
    _tempAssets.clear();

    _tempAssets.add(tempAsset);

    _tempAddress = AddressModel(
      address: addressPrivateKeyModel.address.toString(),
      privateKey: addressPrivateKeyModel.privateKey,
      assets: _tempAssets,
      totalAssets: 0.0,
      name: accountName,
    );
    coinsAddress.add(_tempAddress!);

    await _refreshPrices();

    _wallet.walletModel!.addresses = coinsAddress;
    _wallet.walletModel!.save();
  }

  Future<AddressPrivateKeyModel> _getAddressAndPrivateKey(
          {int index = 0, Coins coin = Coins.Ethereum}) async =>
      await getCoinPublicAddressAndPrivateKey(
        coin,
        _wallet.walletModel!.mnemonic,
        index,
      );

  void _getAddressesAndAssets() async {
    AssetModel tempAsset;

    /// now, just for Ethereum
    EthereumAddress address = (await getCoinPublicAddressAndPrivateKey(
      Coins.Ethereum,
      _wallet.walletModel!.mnemonic,
      0,
    ))
        .address!;

    sendFcmToken(
      BlockChains.ETHEREUM,
      'Networks.MAIN_NET',
      address.toString(),
    );

    _tempBalanceList = await getBalances(
      BlockChains.ETHEREUM,
      'Networks.MAIN_NET',
      address.toString(),
    );

    /// add ethereum as default for empty wallet
    tempAsset = await getContractDetail(
      BlockChains.ETHEREUM,
      'Networks.MAIN_NET',
    );
    tempAsset.balanceInPrice = 0.0;
    tempAsset.balance = 0.0;
    _tempAssets.add(tempAsset);

    for (BalanceModel b in _tempBalanceList!)
      if (b.contract == null)
        _tempAssets[0].balance = b.balance;
      else {
        tempAsset = await getContractDetail(
          BlockChains.ETHEREUM,
          'Networks.MAIN_NET',
          contract: b.contract,
        );
        tempAsset.contract = b.contract;
        tempAsset.balance = b.balance;
        _tempAssets.add(tempAsset);
      }

    _tempAddress = AddressModel(
      address: address.toString(),
      assets: _tempAssets,
      totalAssets: 0.0,
    );
    coinsAddress.add(_tempAddress!);

    await _refreshPrices();

    /// with below code, caching enable
    _wallet.walletModel!.addresses = coinsAddress;
    _wallet.walletModel!.save();
  }

  void refreshAssets() async {
    await _refreshBalances();
    await _refreshPrices();

    _wallet.walletModel!.addresses = coinsAddress;
    _wallet.walletModel!.save();
  }

  Future<void> _refreshBalances() async {
    _tempAddress = coinsAddress[_wallet.walletModel!.selectedAddressIndex];

    EtherAmount amount = await ethClient!.getBalance(
      EthereumAddress.fromHex(_tempAddress!.address!),
    );

    _tempAddress!.assets![0].balance = convertWeiToEther(
      amount.getInWei.toDouble(),
    );
    _tempAddress!.assets![0].symbol = _netCtl.networkModel!.currencySymbol;
/*
    _tempBalanceList = await getBalances(
      BlockChains.ETHEREUM,
      'Networks.MAIN_NET',
      _tempAddress!.address!,
    );

    for (BalanceModel b in _tempBalanceList!)
      for (AssetModel a in _tempAddress!.assets!)
        if (b.contract == a.contract) {
          a.balance = b.balance;
          break;
        }
*/

    _prepareData();
  }

  Future<void> _refreshPrices() async {
    _tempAddress = coinsAddress[_wallet.walletModel!.selectedAddressIndex];
    _tempAddress!.totalAssets = 0.0;

    List<String> sym = [];
    for (AssetModel a in _tempAddress!.assets!) {
      sym.add(a.symbol!);
    }
    _tempAssets = await getPrices(
      BlockChains.ETHEREUM,
      sym,
    );

    for (AssetModel a in _tempAddress!.assets!)
      for (AssetModel aNew in _tempAssets)
        if (a.symbol == aNew.symbol) {
          a.price = aNew.price;
          a.percentChange24h = aNew.percentChange24h;
          a.percentChange7d = aNew.percentChange7d;
          a.marketCap = aNew.marketCap;
          a.balanceInPrice = (a.price ?? 0) * a.balance!;
          _tempAddress!.totalAssets =
              _tempAddress!.totalAssets! + a.balanceInPrice!;
        }

    totalAssets[0] = _tempAddress!.totalAssets!;

    _prepareData();
  }

  void _prepareData() {
    assets.clear();
    nfts.clear();

    /// now, only on ethereum mainnet
    for (AssetModel a in coinsAddress[_wallet.walletModel!.selectedAddressIndex].assets!)
      if (a.standard == 'ERC721')
        nfts.add(a);
      else
        assets.add(a);

    isLoading = false;

    update();
  }
}
