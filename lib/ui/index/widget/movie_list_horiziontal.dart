import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './movie_item_vertical.dart';
import '../../../widget/loading.dart';
import '../../../model/movie.dart';

class MovieListHorizontal extends StatefulWidget {
  final List<Movie> movies;

  const MovieListHorizontal(this.movies);

  @override
  _MovieListHorizontalState createState() => _MovieListHorizontalState();
}

class _MovieListHorizontalState extends State<MovieListHorizontal> {
  @override
  Widget build(BuildContext context) {
    final _movies = widget.movies;

    return Container(
      height: 340.0,
      margin: EdgeInsets.only(bottom: 12.0, top: 12.0),
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          itemExtent: 192.0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final Movie movie = _movies[index];

            return MovieItemVertical(movie);
          },
          itemCount: _movies.length,
        ),
      ),
    );
  }
}
