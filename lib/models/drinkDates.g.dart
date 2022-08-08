// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drinkDates.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkDatesAdapter extends TypeAdapter<DrinkDates> {
  @override
  final int typeId = 1;

  @override
  DrinkDates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrinkDates()
      ..date = fields[0] as String
      ..completedCount = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, DrinkDates obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.completedCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrinkDatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
