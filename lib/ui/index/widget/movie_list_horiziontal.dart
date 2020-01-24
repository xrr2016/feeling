import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './movie_item_vertical.dart';
import '../../../widget/loading.dart';
import '../../../model/movie.dart';
import '../../../data/network/api_client.dart';

class MovieListHorizontal extends StatefulWidget {
  @override
  _MovieListHorizontalState createState() => _MovieListHorizontalState();
}

class _MovieListHorizontalState extends State<MovieListHorizontal> {
  List<Movie> _movies = [];
  int _totalMoviePage = 1;
  int _currentMoviePage = 1;

  Future _getHotMovies({String type = 'upcoming'}) async {
    try {
      Response response = await ApiClient.get(
        '/3/movie/$type',
        queryParameters: {
          "page": _currentMoviePage,
        },
      );

      final data = response.data;
      final results = data["results"] as List;

      results.forEach((r) => _movies.add(Movie.fromJson(r)));
      setState(() {
        _movies = _movies;
        _totalMoviePage = data["total_pages"];
      });
    } on DioError catch (err) {
      throw err;
    }
  }

  @override
  void initState() {
    super.initState();
    _getHotMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.0,
      margin: EdgeInsets.only(bottom: 12.0, top: 12.0),
      child: _movies.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              itemExtent: 192.0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final Movie movie = _movies[index];

                return MovieItemVertical(movie);
              },
              itemCount: _movies.length,
            )
          : Loading(),
    );
  }
}
