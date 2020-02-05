import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../model/movie.dart';
import '../../../data/network/api_client.dart';

class TrendingProvider extends ChangeNotifier {
  TrendingProvider() {
    getTrendingMovies();
  }

  String _message = '';
  int _totalPage = 1;
  int _currentPage = 1;
  bool _isLoading = false;
  List<Movie> _movies = [];

  get message => _message;

  get movies => _movies;

  get isLoading => _isLoading;

  get totalPage => _totalPage;

  get currentPage => _currentPage;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(String val) {
    _message = val;
    notifyListeners();
  }

  void setData(Response response) {
    final data = response.data;
    final results = data["results"] as List;
    _totalPage = data["total_pages"];

    results.forEach((r) => _movies.add(Movie.fromJson(r)));

    notifyListeners();
  }

  Future getTrendingMovies({String time = 'day'}) async {
    setLoading(true);
    try {
      Response response = await apiClient.get(
        '/3/trending/movie/$time',
        queryParameters: {"page": _currentPage},
      );

      setData(response);
    } on DioError catch (err) {
      setMessage(err.message);
    } finally {
      setLoading(false);
    }
  }
}
