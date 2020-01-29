// To parse this JSON data, do
// final movie = movieFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final bool video;
  @HiveField(2)
  final int voteCount;
  @HiveField(3)
  final double voteAverage;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final String releaseDate;
  @HiveField(6)
  final String originalLanguage;
  @HiveField(7)
  final String originalTitle;
  @HiveField(8)
  final List<int> genreIds;
  @HiveField(9)
  final String backdropPath;
  @HiveField(10)
  final bool adult;
  @HiveField(11)
  final String overview;
  @HiveField(12)
  final String posterPath;
  @HiveField(13)
  final double popularity;
  @HiveField(14)
  final String mediaType;

  Movie({
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.popularity,
    this.mediaType,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        video: json["video"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        releaseDate: json["release_date"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        backdropPath: json["backdrop_path"],
        adult: json["adult"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "vote_count": voteCount,
        "vote_average": voteAverage,
        "title": title,
        "release_date": releaseDate,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "backdrop_path": backdropPath,
        "adult": adult,
        "overview": overview,
        "poster_path": posterPath,
        "popularity": popularity,
        "media_type": mediaType,
      };
}
