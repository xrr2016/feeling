import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../model/movie.dart';
import '../../../widget/loading.dart';
import '../widget/movie_list_trending.dart';
import '../../../data/network/api_client.dart';

class IndexTrending extends StatefulWidget {
  @override
  _IndexTrendingState createState() => _IndexTrendingState();
}

class _IndexTrendingState extends State<IndexTrending>
    with AutomaticKeepAliveClientMixin {
  int _totalTendingPage = 1;
  int _currentTrendingPage = 1;
  List<Movie> _trendingMovies = [];
  bool _isLoadingTrending = false;
  bool _isLoadingData = false;

  //  RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  // void _onRefresh() async{
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   _refreshController.refreshCompleted();
  // }

  Future _fetchData() async {
    setState(() {
      _isLoadingData = true;
    });

    List<Future> futures = List<Future>();
    futures.add(_getTrending());
    await Future.wait(futures);

    setState(() {
      _isLoadingData = false;
    });
  }

  Future _getTrending({String time = 'day'}) async {
    _isLoadingTrending = true;
    try {
      Response response = await apiClient.get(
        '/3/trending/movie/$time',
        queryParameters: {
          "page": _currentTrendingPage,
        },
      );

      final data = response.data;
      final results = data["results"] as List;
      _totalTendingPage = data["total_pages"];

      results.forEach((r) => _trendingMovies.add(Movie.fromJson(r)));
      setState(() {
        _trendingMovies = _trendingMovies;
      });
      return true;
    } on DioError catch (err) {
      throw err;
    } finally {
      _isLoadingTrending = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
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
          setState(() {
            _totalTendingPage = 1;
            _currentTrendingPage = 1;
            _trendingMovies = [];
          });

          return _getTrending();
        },
        child: NotificationListener<ScrollNotification>(
          child: MovieListTrending(_trendingMovies),
          onNotification: (ScrollNotification scrollInfo) {
            final metrics = scrollInfo.metrics;

            if (metrics.pixels >= metrics.maxScrollExtent) {
              if (_currentTrendingPage < _totalTendingPage &&
                  !_isLoadingTrending) {
                _currentTrendingPage++;
                _getTrending();
              }
            }
            return;
          },
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
