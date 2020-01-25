import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './movie_item.dart';
import '../../../model/movie.dart';
import '../../../widget/loading.dart';
import '../../../data/network/api_client.dart';

class MovieListTrending extends StatefulWidget {
  @override
  _MovieListTrendingState createState() => _MovieListTrendingState();
}

class _MovieListTrendingState extends State<MovieListTrending> {
  bool _isLoadingData = false;
  int _currentPage = 1;
  int _totalPage = 1;

  List<Movie> _movies = [];

  Future _getTrendingList({String time = 'day'}) async {
    _isLoadingData = true;
    try {
      Response response = await ApiClient.get(
        '/3/trending/movie/$time',
        queryParameters: {
          "page": _currentPage,
        },
      );

      final data = response.data;
      final results = data["results"] as List;

      results.forEach((r) => _movies.add(Movie.fromJson(r)));
      setState(() {
        _movies = _movies;
        _totalPage = data["total_pages"];
      });
    } on DioError catch (err) {
      throw err;
    } finally {
      _isLoadingData = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getTrendingList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _movies.isNotEmpty
          ? Scrollbar(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
                child: ListView.builder(
                  itemCount: _movies.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                  itemBuilder: (_, int index) {
                    Movie movie = _movies[index];
                    return MovieItem(movie);
                  },
                ),
              ),
            )
          : Loading(),
    );
  }
}
