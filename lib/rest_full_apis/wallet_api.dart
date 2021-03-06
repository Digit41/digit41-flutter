import 'package:digit41/models/asset_model.dart';
import 'package:digit41/models/balance_model.dart';
import 'package:digit41/models/trx_model.dart';
import 'package:digit41/rest_full_apis/base_api.dart';
import 'package:digit41/rest_full_apis/routes.dart';

Future<List<BalanceModel>> getBalances(
  String blockChain,
  String network,
  String address,
) async {
  var result = await anyApi(
    method: 'get',
    url: Routes.BALANCES,
    queryParam: {
      'blockchain': blockChain,
      'network': network,
      'address': address,
      'force_update': 'true',
    },
  );

  return balanceModelListFromJson(result);
}

Future<AssetModel> getContractDetail(String blockChain, String network,
    {String? contract}) async {
  var result = await anyApi(
    method: 'get',
    url: Routes.CONTRACTS +
        '/$blockChain/$network${contract == null ? '' : '/' + contract}',
  );

  return AssetModel.fromJson(result);
}

Future<List<AssetModel>> getPrices(
  String blockChain,
  List<String> symbols,
) async {
  var result = await anyApi(
    method: 'post',
    url: Routes.PRICES,
    data: {
      'blockchain': blockChain,
      'network': 'mainnet',
      'symbol': symbols,
    },
  );

  return assetModelsPriceFromJson(result);
}

Future<List<TrxModel>> getTrxs(String blockChain, String network, String address,
    {String? contract, String forceUpdate = 'true'}) async {
  var qp = {
    'blockchain': blockChain,
    'network': network,
    'address': address,
    'force_update': forceUpdate,
  };

  if (contract != null) qp['contract'] = contract;

  var result = await anyApi(
    method: 'get',
    url: Routes.TRANSACTIONS,
    queryParam: qp,
  );

  return trxsFromJson(result);
}

void sendFcmToken(
  String blockChain,
  String network,
  String address,
) async {
  // AppFCMPushNotification appFCMPushNotification = AppFCMPushNotification();
  String fcmToken = '';

  anyApi(
    method: 'get',
    url: Routes.FCM_TOKEN,
    queryParam: {
      'blockchain': blockChain,
      'network': network,
      'address': address,
      'fcm_token': fcmToken,
    },
  );
}
