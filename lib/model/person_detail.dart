// To parse this JSON data, do
//
// final personDetail = personDetailFromJson(jsonString);

import 'dart:convert';

class PersonDetail {
  final String birthday;
  final String knownForDepartment;
  final dynamic deathday;
  final int id;
  final String name;
  final List<String> alsoKnownAs;
  final int gender;
  final String biography;
  final double popularity;
  final String placeOfBirth;
  final String profilePath;
  final bool adult;
  final String imdbId;
  final dynamic homepage;

  PersonDetail({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  factory PersonDetail.fromRawJson(String str) =>
      PersonDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PersonDetail.fromJson(Map<String, dynamic> json) => PersonDetail(
        birthday: json["birthday"],
        knownForDepartment: json["known_for_department"],
        deathday: json["deathday"],
        id: json["id"],
        name: json["name"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );

  Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "known_for_department": knownForDepartment,
        "deathday": deathday,
        "id": id,
        "name": name,
        "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
        "gender": gender,
        "biography": biography,
        "popularity": popularity,
        "place_of_birth": placeOfBirth,
        "profile_path": profilePath,
        "adult": adult,
        "imdb_id": imdbId,
        "homepage": homepage,
      };
}
