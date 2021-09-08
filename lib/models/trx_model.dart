List<TrxModel> trxsFromJson(data) => data.map<TrxModel>((x) => TrxModel.fromJson(x)).toList();

class TrxModel {
  TrxModel({
    this.id,
    this.network,
    this.blockchain,
    this.recipient,
    this.sender,
    this.type,
    this.blockId,
    this.contract,
    this.fee,
    this.gas,
    this.gasPrice,
    this.amount,
    this.hash,
    this.notification,
    this.title,
    this.status,
    this.createdAt,
  });

  int? id;
  String? network;
  String? blockchain;
  String? recipient;
  String? sender;
  dynamic type;
  int? blockId;
  dynamic contract;
  double? fee;
  double? gas;
  double? gasPrice;
  double? amount;
  String? hash;
  bool? notification;
  dynamic title;
  dynamic status;
  double? createdAt;

  factory TrxModel.fromJson(Map<String, dynamic> json) =>
      TrxModel(
        id: json["id"],
        network: json["network"],
        blockchain: json["blockchain"],
        recipient: json["recipient"],
        sender: json["sender"],
        type: json["type"],
        blockId: json["block_id"],
        contract: json["contract"],
        fee: json["fee"].toDouble(),
        gas: json["gas"],
        gasPrice: json["gas_price"].toDouble(),
        amount: json["amount"],
        hash: json["hash"],
        notification: json["notification"],
        title: json["title"],
        status: json["status"],
        createdAt: json["created_at"].toDouble(),
      );
}