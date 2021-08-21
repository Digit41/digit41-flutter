import 'package:hive/hive.dart';

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
  DateTime? lastUpdate;

  AssetModel({
    this.contract,
    this.name,
    this.symbol,
    this.decimals,
    this.balance,
    this.abi,
    this.icon,
    this.standard,
    this.lastUpdate,
  });
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
      lastUpdate: fields[8],
    );
  }

  @override
  void write(BinaryWriter writer, AssetModel obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.lastUpdate);
  }
}
