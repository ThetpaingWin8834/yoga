// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 3;

  @override
  CartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItem(
      classId: fields[0] as int,
      courseId: fields[1] as int,
      dateOfClass: fields[2] as String,
      teacher: fields[3] as String,
      comments: fields[4] as String,
      dayOfWeek: fields[5] as String?,
      timeOfCourse: fields[6] as String?,
      capacityOfClass: fields[7] as String?,
      durationOfClass: fields[8] as String?,
      priceOfClass: fields[9] as String?,
      typeOfClass: fields[10] as String?,
      descriptionOfClass: fields[11] as String?,
      locationOfClass: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.classId)
      ..writeByte(1)
      ..write(obj.courseId)
      ..writeByte(2)
      ..write(obj.dateOfClass)
      ..writeByte(3)
      ..write(obj.teacher)
      ..writeByte(4)
      ..write(obj.comments)
      ..writeByte(5)
      ..write(obj.dayOfWeek)
      ..writeByte(6)
      ..write(obj.timeOfCourse)
      ..writeByte(7)
      ..write(obj.capacityOfClass)
      ..writeByte(8)
      ..write(obj.durationOfClass)
      ..writeByte(9)
      ..write(obj.priceOfClass)
      ..writeByte(10)
      ..write(obj.typeOfClass)
      ..writeByte(11)
      ..write(obj.descriptionOfClass)
      ..writeByte(12)
      ..write(obj.locationOfClass);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
