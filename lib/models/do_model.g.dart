import 'package:hive/hive.dart';

import 'do_model.dart';

class DoModelAdapter extends TypeAdapter<DoModel> {
  @override
  final int typeId = 1;

  @override
  DoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoModel(
      index: fields[1] as int,
      task: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DoModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
