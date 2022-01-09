// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTableAdapter extends TypeAdapter<UserTable> {
  @override
  final int typeId = 1;

  @override
  UserTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTable();
  }

  @override
  void write(BinaryWriter writer, UserTable obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
