// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryAdapter extends TypeAdapter<Story> {
  @override
  final typeId = 0;

  @override
  Story read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Story(
      movie: fields[4] as Movie,
      movieId: fields[5] as String,
      createDate: fields[6] as String,
      updateDate: fields[7] as String,
      watchDate: fields[0] as String,
      rate: fields[2] as double,
      feel: fields[1] as String,
      review: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Story obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.watchDate)
      ..writeByte(1)
      ..write(obj.feel)
      ..writeByte(2)
      ..write(obj.rate)
      ..writeByte(3)
      ..write(obj.review)
      ..writeByte(4)
      ..write(obj.movie)
      ..writeByte(5)
      ..write(obj.movieId)
      ..writeByte(6)
      ..write(obj.createDate)
      ..writeByte(7)
      ..write(obj.updateDate);
  }
}
