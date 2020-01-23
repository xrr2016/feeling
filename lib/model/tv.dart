// To parse this JSON data, do
// final tv = tvFromJson(jsonString);

import 'dart:convert';

class Tv {
  final String originalName;
  final int id;
  final String name;
  final int voteCount;
  final double voteAverage;
  final String firstAirDate;
  final String posterPath;
  final List<int> genreIds;
  final String originalLanguage;
  final String backdropPath;
  final String overview;
  final List<String> originCountry;
  final double popularity;
  final String mediaType;

  Tv({
    this.originalName,
    this.id,
    this.name,
    this.voteCount,
    this.voteAverage,
    this.firstAirDate,
    this.posterPath,
    this.genreIds,
    this.originalLanguage,
    this.backdropPath,
    this.overview,
    this.originCountry,
    this.popularity,
    this.mediaType,
  });

  factory Tv.fromRawJson(String str) => Tv.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tv.fromJson(Map<String, dynamic> json) => Tv(
        originalName: json["original_name"],
        id: json["id"],
        name: json["name"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"],
        firstAirDate: json["first_air_date"],
        posterPath: json["poster_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        backdropPath: json["backdrop_path"],
        overview: json["overview"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"],
      );

  Map<String, dynamic> toJson() => {
        "original_name": originalName,
        "id": id,
        "name": name,
        "vote_count": voteCount,
        "vote_average": voteAverage,
        "first_air_date": firstAirDate,
        "poster_path": posterPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_language": originalLanguage,
        "backdrop_path": backdropPath,
        "overview": overview,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "popularity": popularity,
        "media_type": mediaType,
      };
}
