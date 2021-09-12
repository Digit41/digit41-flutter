import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class NetworkModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? url;

  @HiveField(2)
  int? chainId;

  @HiveField(3)
  String? currencySymbol;

  @HiveField(4)
  String? blockExplorerURL;

  @HiveField(5)
  bool selected;

  /// this field is for detect user networks from default networks
  @HiveField(6)
  bool byUser;

  NetworkModel({
    this.name,
    this.url,
    this.chainId,
    this.currencySymbol,
    this.blockExplorerURL,
    this.selected = false,
    this.byUser = false,
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
      chainId: fields[2],
      currencySymbol: fields[3],
      blockExplorerURL: fields[4],
      selected: fields[5],
      byUser: fields[6],
    );
  }

  @override
  void write(BinaryWriter writer, NetworkModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.chainId)
      ..writeByte(3)
      ..write(obj.currencySymbol)
      ..writeByte(4)
      ..write(obj.blockExplorerURL)
      ..writeByte(5)
      ..write(obj.selected)
      ..writeByte(6)
      ..write(obj.byUser);
  }
}
