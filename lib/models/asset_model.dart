import 'package:hive/hive.dart';

List<AssetModel> assetModelsPriceFromJson(data) =>
    data.map<AssetModel>((x) => AssetModel.fromJsonForPrice(x)).toList();

@HiveType(typeId: 2)
class AssetModel extends HiveObject {
  @HiveField(0)
  String? contract;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? symbol;

  @HiveField(3)
  int? decimals;

  @HiveField(4)
  double? balance;

  @HiveField(5)
  String? abi;

  @HiveField(6)
  String? icon;

  @HiveField(7)
  String? standard;

  @HiveField(8)
  String? description;

  @HiveField(9)
  double? balanceInPrice;

  @HiveField(10)
  double? price;

  @HiveField(11)
  double? percentChange24h;

  @HiveField(12)
  double? percentChange7d;

  @HiveField(13)
  double? marketCap;

  @HiveField(14)
  int? precision;

  AssetModel({
    this.contract,
    this.name,
    this.symbol,
    this.decimals,
    this.balance,
    this.abi,
    this.icon,
    this.standard,
    this.description,
    this.balanceInPrice,
    this.price,
    this.percentChange24h,
    this.percentChange7d,
    this.marketCap,
    this.precision,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      AssetModel(
        icon: json["icon"],
        abi: json["abi"],
        decimals: json["decimals"],
        name: json["name"],
        description: json["description"],
        symbol: json["symbol"],
        standard: json["standard"],
        precision: json["precision"],
      );

  factory AssetModel.fromJsonForPrice(Map<String, dynamic> json) =>
      AssetModel(
        symbol: json['symbol'],
        price: json['price'],
        percentChange24h: json['percent_change_24h'],
        percentChange7d: json['percent_change_7d'],
        marketCap: json['market_cap'],
      );
}

class AssetAdapter extends TypeAdapter<AssetModel> {
  @override
  final typeId = 2;

  @override
  AssetModel read(BinaryReader reader) {
    int numOfFields = reader.readByte();
    Map fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return AssetModel(
      contract: fields[0],
      name: fields[1],
      symbol: fields[2],
      decimals: fields[3],
      balance: fields[4],
      abi: fields[5],
      icon: fields[6],
      standard: fields[7],
      description: fields[8],
      balanceInPrice: fields[9],
      price: fields[10],
      percentChange24h: fields[11],
      percentChange7d: fields[12],
      marketCap: fields[13],
      precision: fields[14],
    );
  }

  @override
  void write(BinaryWriter writer, AssetModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.contract)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.decimals)
      ..writeByte(4)
      ..write(obj.balance)
      ..writeByte(5)
      ..write(obj.abi)
      ..writeByte(6)
      ..write(obj.icon)
      ..writeByte(7)
      ..write(obj.standard)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.balanceInPrice)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.percentChange24h)
      ..writeByte(12)
      ..write(obj.percentChange7d)
      ..writeByte(13)
      ..write(obj.marketCap)
      ..writeByte(14)
      ..write(obj.precision);
  }
}
