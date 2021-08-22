
List<BalanceModel> balanceModelListFromJson(data) => data.map<BalanceModel>((x) => BalanceModel.fromJson(x)).toList();

class BalanceModel{
  String? contract;
  double? balance;

  BalanceModel({this.contract, this.balance});
  
  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    contract: json['contract'],
    balance: json['balance'],
  );
}