import 'package:flutter/material.dart';

import '../../../styles.dart';
import './movie_item_vertical.dart';
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
      height: 366.0,
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
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
