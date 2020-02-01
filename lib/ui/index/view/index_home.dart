import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../model/movie.dart';
import '../../../widget/loading.dart';
import '../widget/movie_list_horiziontal.dart';
import '../../../data/network/api_client.dart';

class IndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome>
    with AutomaticKeepAliveClientMixin {
  bool _isLoadingData = false;
  bool _isLoadingMovies = false;

  List<Movie> _top = [];
  int _topTotal = 1;
  int _topCurrent = 1;

  List<Movie> _playing = [];
  int _playingTotal = 1;
  int _playingCurrent = 1;

  List<Movie> _popular = [];
  int _popularTotal = 1;
  int _popularCurrent = 1;

  List<Movie> _upcoming = [];
  int _upcomingTotal = 1;
  int _upcomingCurrent = 1;

  Future _fetchAllMovies() async {
    setState(() {
      _isLoadingData = true;
    });

    List<Future> futures = List<Future>();

    futures.add(_getMovies(type: 'popular', page: _popularCurrent));
    futures.add(_getMovies(type: 'upcoming', page: _upcomingCurrent));
    futures.add(_getMovies(type: 'now_playing', page: _playingCurrent));
    futures.add(_getMovies(type: 'top_rated', page: _topCurrent));

    await Future.wait(futures);

    setState(() {
      _isLoadingData = false;
    });
  }

  Future _getMovies({String type = 'upcoming', int page}) async {
    _isLoadingMovies = true;
    try {
      Response response = await apiClient.get(
        '/3/movie/$type',
        queryParameters: {"page": page},
      );

      final data = response.data;
      final results = data["results"] as List;

      switch (type) {
        case 'popular':
          _popularTotal = data["total_pages"];
          results.forEach((r) => _popular.add(Movie.fromJson(r)));
          setState(() => _popular = _popular);
          break;

        case 'upcoming':
          _upcomingTotal = data["total_pages"];
          results.forEach((r) => _upcoming.add(Movie.fromJson(r)));
          setState(() => _upcoming = _upcoming);
          break;

        case 'top_rated':
          _topTotal = data["total_pages"];
          results.forEach((r) => _top.add(Movie.fromJson(r)));
          setState(() => _top = _top);
          break;

        case 'now_playing':
          _playingTotal = data["total_pages"];
          results.forEach((r) => _playing.add(Movie.fromJson(r)));
          setState(() => _playing = _playing);
          break;
      }
    } on DioError catch (err) {
      throw err;
    } finally {
      _isLoadingMovies = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovies(type: 'popular', page: _popularCurrent);
    _getMovies(type: 'upcoming', page: _upcomingCurrent);
    _getMovies(type: 'now_playing', page: _playingCurrent);
    _getMovies(type: 'top_rated', page: _topCurrent);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isLoadingData) {
      return Loading();
    } else {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        onRefresh: () {
          _isLoadingData = false;
          _isLoadingMovies = false;

          _popularCurrent = 1;
          _popularTotal = 1;

          _upcomingCurrent = 1;
          _upcomingTotal = 1;

          _playingCurrent = 1;
          _playingTotal = 1;

          _topCurrent = 1;
          _topTotal = 1;

          setState(() {
            _popular = [];
            _upcoming = [];
            _playing = [];
            _top = [];
          });

          return _fetchAllMovies();
        },
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            NotificationListener<ScrollNotification>(
              child: MovieListHorizontal(_popular, 'Popular'),
              onNotification: (ScrollNotification scrollInfo) {
                final metrics = scrollInfo.metrics;

                if (metrics.pixels >= metrics.maxScrollExtent) {
                  if (_popularCurrent < _popularTotal && !_isLoadingMovies) {
                    _popularCurrent++;
                    _getMovies(type: 'popular', page: _popularCurrent);
                  }
                }
                return;
              },
            ),
            NotificationListener<ScrollNotification>(
              child: MovieListHorizontal(_playing, 'Playing'),
              onNotification: (ScrollNotification scrollInfo) {
                final metrics = scrollInfo.metrics;

                if (metrics.pixels >= metrics.maxScrollExtent) {
                  if (_playingCurrent < _playingTotal && !_isLoadingMovies) {
                    _playingCurrent++;
                    _getMovies(type: 'now_playing', page: _playingCurrent);
                  }
                }
                return;
              },
            ),
            NotificationListener<ScrollNotification>(
              child: MovieListHorizontal(_upcoming, 'Upcoming'),
              onNotification: (ScrollNotification scrollInfo) {
                final metrics = scrollInfo.metrics;

                if (metrics.pixels >= metrics.maxScrollExtent) {
                  if (_upcomingCurrent < _upcomingTotal && !_isLoadingMovies) {
                    _upcomingCurrent++;
                    _getMovies(type: 'upcoming', page: _upcomingCurrent);
                  }
                }
                return;
              },
            ),
            NotificationListener<ScrollNotification>(
              child: MovieListHorizontal(_top, 'Top'),
              onNotification: (ScrollNotification scrollInfo) {
                final metrics = scrollInfo.metrics;

                if (metrics.pixels >= metrics.maxScrollExtent) {
                  if (_topCurrent < _topTotal && !_isLoadingMovies) {
                    _topCurrent++;
                    _getMovies(type: 'top_rated', page: _topCurrent);
                  }
                }
                return;
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
