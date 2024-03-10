// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpn_config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VPNConfigModelAdapter extends TypeAdapter<VPNConfigModel> {
  @override
  final int typeId = 0;

  @override
  VPNConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VPNConfigModel(
      countryImage: fields[0] as String?,
      countryName: fields[1] as String?,
      config: fields[2] as String?,
      ping: fields[3] as String?,
      isSelected: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, VPNConfigModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.countryImage)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.config)
      ..writeByte(3)
      ..write(obj.ping)
      ..writeByte(4)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VPNConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
