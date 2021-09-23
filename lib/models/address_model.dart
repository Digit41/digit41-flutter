import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class AddressModel extends HiveObject {
  @HiveField(0)
  String? address;

  @HiveField(1)
  List? assets;

  @HiveField(2)
  double? totalAssets;


  AddressModel({
    this.address,
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
      assets: fields[1],
      totalAssets: fields[2],
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.assets)
      ..writeByte(2)
      ..write(obj.totalAssets);
  }
}
