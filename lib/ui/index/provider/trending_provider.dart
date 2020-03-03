import 'package:flutter/material.dart';
import 'package:Feeling/service/tmdb.dart';

import '../../../model/movie.dart';

class TrendingProvider extends ChangeNotifier {
  String _message = '';
  String get message => _message;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _totalPage = 1;
  int get totalPage => _totalPage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(String val) {
    _message = val;
    notifyListeners();
  }

  Future loadMoreMovies() async {
    _currentPage++;

    if (_currentPage < _totalPage && !_isLoading) {
      await getTrendingMovies();
    }
  }

  Future refreshTrendingMovies() async {
    _currentPage = 1;
    _totalPage = 1;
    _movies = [];
    _isLoading = false;

    await getTrendingMovies();
  }

  Future getTrendingMovies() async {
    setLoading(true);
    setMessage('');

    final result = await Tmdb.getTrendingMovies(
      time: 'day',
      page: _currentPage,
    );
    if (result is Map) {
      _movies = result['movies'];
      _totalPage = result['total'];
    } else {
      setMessage(result);
    }
    setLoading(false);
    notifyListeners();
  }
}
