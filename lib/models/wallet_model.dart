import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class WalletModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String mnemonic;

  @HiveField(2)
  bool selected;

  @HiveField(3)
  List? addresses;

  @HiveField(4)
  int selectedAddressIndex;

  WalletModel(
    this.name,
    this.mnemonic, {
    this.selected = false,
    this.addresses,
    this.selectedAddressIndex = 0,
  });
}

//wallet adapter for hive
class WalletAdapter extends TypeAdapter<WalletModel> {
  @override
  final typeId = 0;

  @override
  WalletModel read(BinaryReader reader) {
    int numOfFields = reader.readByte();
    Map fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return WalletModel(
      fields[0],
      fields[1],
      selected: fields[2],
      addresses: fields[3],
      selectedAddressIndex: fields[4],
    );
  }

  @override
  void write(BinaryWriter writer, WalletModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.mnemonic)
      ..writeByte(2)
      ..write(obj.selected)
      ..writeByte(3)
      ..write(obj.addresses)
      ..writeByte(4)
      ..write(obj.selectedAddressIndex);
  }
}
