import 'package:feeling/model/movie.dart';
import 'package:flutter/material.dart';

class Story {
  int id;
  Movie movie;
  String createDate;
  String updateDate;
  String watchDate;
  String feel;
  double rate;
  String review;

  Story({
    @required this.id,
    @required this.movie,
    @required this.createDate,
    @required this.updateDate,
    this.watchDate,
    this.feel = 'haha',
    this.rate = 5.0,
    this.review = 'nothing to say.',
  });
}
