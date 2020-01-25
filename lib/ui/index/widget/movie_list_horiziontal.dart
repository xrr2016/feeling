import 'package:flutter/material.dart';

import './movie_item_vertical.dart';
import '../../../model/movie.dart';
import '../../../widget/loading.dart';

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
      height: 360.0,
      child: _movies.isNotEmpty
          ? Scrollbar(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 24.0,
                  top: 12.0,
                ),
                itemExtent: 192.0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final Movie movie = _movies[index];

                  return MovieItemVertical(movie);
                },
                itemCount: _movies.length,
              ),
            )
          : Loading(),
    );
  }
}
