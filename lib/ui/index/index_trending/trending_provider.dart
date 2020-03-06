import 'package:flutter/material.dart';
import 'package:Feeling/service/tmdb.dart';

import '../../../model/movie.dart';

class TrendingProvider extends ChangeNotifier {
  bool init = true;

  String _message = '';
  String get message => _message;

  String _time = 'day';
  String get time => _time;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _totalPage = 1;
  int get totalPage => _totalPage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  void _clear() {
    _currentPage = 1;
    _totalPage = 1;
    _movies.clear();
    _isLoading = false;
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(String val) {
    _message = val;
    notifyListeners();
  }

  void setTime(String val) async {
    _time = val;
    _clear();
    await getTrendingMovies();
    notifyListeners();
  }

  Future loadMoreMovies() async {
    _currentPage++;

    if (_currentPage < _totalPage && !_isLoading) {
      await getTrendingMovies();
    }
  }

  Future refreshTrendingMovies() async {
    _clear();

    await getTrendingMovies();
  }

  Future getTrendingMovies() async {
    setLoading(true);

    final result = await Tmdb.getTrendingMovies(
      time: _time,
      page: _currentPage,
    );
    if (result is Map) {
      _movies.addAll(result['movies']);
      _totalPage = result['total'];
    } else {
      setMessage(result);
    }
    setLoading(false);
    init = false;
    notifyListeners();
  }
}
