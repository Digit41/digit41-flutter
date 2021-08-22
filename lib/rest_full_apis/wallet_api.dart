import 'package:digit41/models/balance_model.dart';
import 'package:digit41/rest_full_apis/base_api.dart';
import 'package:digit41/rest_full_apis/routes.dart';

Future getBalances(
  String blockChain,
  String network,
  String address,
) async {
  var result = await anyApi(
    method: 'get',
    url: Routes.BALANCES +
        'blockchain=$blockChain&network=$network&address=$address&force_update=true',
  );

  return balanceModelListFromJson(result);
}
