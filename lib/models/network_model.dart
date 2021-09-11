import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class NetworkModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? url;

  @HiveField(2)
  bool selected;


  NetworkModel({
    this.name,
    this.url,
    this.selected = false,
  });
}

class NetworkAdapter extends TypeAdapter<NetworkModel> {
  @override
  final typeId = 3;

  @override
  NetworkModel read(BinaryReader reader) {
    int numOfFields = reader.readByte();
    Map fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return NetworkModel(
      name: fields[0],
      url: fields[1],
      selected: fields[2],
    );
  }

  @override
  void write(BinaryWriter writer, NetworkModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.selected);
  }
}
