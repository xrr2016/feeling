import 'package:feeling/model/movie.dart';
import 'package:flutter/material.dart';

class Story {
  final Movie movie;
  final String createDate;
  String updateDate;
  String watchDate;
  String feel;
  double rate;
  String review;

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
