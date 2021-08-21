import 'package:digit41/models/asset_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class AddressModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? address;

  @HiveField(2)
  String? blockChain;

  @HiveField(3)
  String? network;

  @HiveField(4)
  List<AssetModel>? assets;


  AddressModel({
    this.name,
    this.address,
    this.blockChain,
    this.network,
    this.assets,
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
      name: fields[0],
      address: fields[1],
      blockChain: fields[2],
      network: fields[3],
      assets: fields[4],
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.blockChain)
      ..writeByte(3)
      ..write(obj.network)
      ..writeByte(4)
      ..write(obj.assets);
  }
}
