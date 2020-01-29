import 'package:feeling/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'story.g.dart';

@HiveType(typeId: 0)
class Story {
  @HiveField(0)
  String watchDate;
  @HiveField(1)
  String feel;
  @HiveField(2)
  double rate;
  @HiveField(3)
  String review;
  @HiveField(4)
  final Movie movie;
  @HiveField(5)
  final String createDate;
  @HiveField(6)
  String updateDate;

  Story({
    @required this.movie,
    @required this.createDate,
    @required this.updateDate,
    this.watchDate,
    this.rate = 5.0,
    this.feel = 'haha',
    this.review = 'nothing to say.',
  });
}
