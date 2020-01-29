// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final typeId = 1;

  @override
  Movie read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as int,
      video: fields[1] as bool,
      voteCount: fields[2] as int,
      voteAverage: fields[3] as double,
      title: fields[4] as String,
      releaseDate: fields[5] as String,
      originalLanguage: fields[6] as String,
      originalTitle: fields[7] as String,
      genreIds: (fields[8] as List)?.cast<int>(),
      backdropPath: fields[9] as String,
      adult: fields[10] as bool,
      overview: fields[11] as String,
      posterPath: fields[12] as String,
      popularity: fields[13] as double,
      mediaType: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.video)
      ..writeByte(2)
      ..write(obj.voteCount)
      ..writeByte(3)
      ..write(obj.voteAverage)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.originalLanguage)
      ..writeByte(7)
      ..write(obj.originalTitle)
      ..writeByte(8)
      ..write(obj.genreIds)
      ..writeByte(9)
      ..write(obj.backdropPath)
      ..writeByte(10)
      ..write(obj.adult)
      ..writeByte(11)
      ..write(obj.overview)
      ..writeByte(12)
      ..write(obj.posterPath)
      ..writeByte(13)
      ..write(obj.popularity)
      ..writeByte(14)
      ..write(obj.mediaType);
  }
}
