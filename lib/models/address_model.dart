import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class AddressModel extends HiveObject {
  @HiveField(0)
  String? address;

  @HiveField(1)
  String? blockChain;

  @HiveField(2)
  String? network;

  @HiveField(3)
  List? assets;

  @HiveField(4)
  double? totalAssets;


  AddressModel({
    this.address,
    this.blockChain,
    this.network,
    this.assets,
    this.totalAssets,
  });
}

class AddressAdapter extends TypeAdapter<AddressModel> {
  @override
  final typeId = 1;

  @override
  AddressModel read(BinaryReader reader) {
    int numOfFields = reader.readByte();
    Map fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return AddressModel(
      address: fields[0],
      blockChain: fields[1],
      network: fields[2],
      assets: fields[3],
      totalAssets: fields[4],
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.blockChain)
      ..writeByte(2)
      ..write(obj.network)
      ..writeByte(3)
      ..write(obj.assets)
      ..writeByte(4)
      ..write(obj.totalAssets);
  }
}
