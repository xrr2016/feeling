// To parse this JSON data, do
// final person = personFromJson(jsonString);

import 'dart:convert';

class Person {
  final bool adult;
  final int gender;
  final String name;
  final int id;
  final List<KnownFor> knownFor;
  final String knownForDepartment;
  final String profilePath;
  final double popularity;
  final String mediaType;

  Person({
    this.adult,
    this.gender,
    this.name,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.profilePath,
    this.popularity,
    this.mediaType,
  });

  factory Person.fromRawJson(String str) => Person.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        adult: json["adult"],
        gender: json["gender"],
        name: json["name"],
        id: json["id"],
        knownFor: List<KnownFor>.from(
            json["known_for"].map((x) => KnownFor.fromJson(x))),
        knownForDepartment: json["known_for_department"],
        profilePath: json["profile_path"],
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "name": name,
        "id": id,
        "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
        "known_for_department": knownForDepartment,
        "profile_path": profilePath,
        "popularity": popularity,
        "media_type": mediaType,
      };
}

class KnownFor {
  final int id;
  final bool video;
  final int voteCount;
  final double voteAverage;
  final String title;
  final DateTime releaseDate;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String posterPath;
  final double popularity;
  final String mediaType;

  KnownFor({
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

  factory KnownFor.fromRawJson(String str) =>
      KnownFor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        id: json["id"],
        video: json["video"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        releaseDate: DateTime.parse(json["release_date"]),
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
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
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
