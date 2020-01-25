// To parse this JSON data, do
// final cast = castFromJson(jsonString);

import 'dart:convert';

class Cast {
  final int castId;
  final String character;
  final String creditId;
  final int gender;
  final int id;
  final String name;
  final int order;
  final String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "gender": gender,
        "id": id,
        "name": name,
        "order": order,
        "profile_path": profilePath,
      };
}
