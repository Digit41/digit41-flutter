import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class AddressModel extends HiveObject {
  @HiveField(0)
  String? address;

  @HiveField(1)
  String? privateKey;

  @HiveField(2)
  List? assets;

  @HiveField(3)
  double? totalAssets;

  AddressModel({
    this.address,
    this.privateKey,
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
      privateKey: fields[1],
      assets: fields[2],
      totalAssets: fields[3],
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.privateKey)
      ..writeByte(2)
      ..write(obj.assets)
      ..writeByte(3)
      ..write(obj.totalAssets);
  }
}
