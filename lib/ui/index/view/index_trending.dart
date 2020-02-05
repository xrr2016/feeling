import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../model/movie.dart';
import '../provider/trending_provider.dart';
import '../../../ui/index/widget/movie_item.dart';
import '../../../data/network/api_client.dart';

class IndexTrending extends StatefulWidget {
  @override
  _IndexTrendingState createState() => _IndexTrendingState();
}

class _IndexTrendingState extends State<IndexTrending>
    with AutomaticKeepAliveClientMixin {
  int _totalPage = 1;
  int _currentPage = 1;
  List<Movie> _movies = [];
  bool _isLoading = false;
  RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void initState() {
    final page = Provider.of<TrendingProvider>(context).currentPage;

    print(page);
    super.initState();
  }

  void _onRefresh() async {
    if (mounted) {
      _totalPage = 1;
      _currentPage = 1;
      _movies = await _getTrendingMovies();
      setState(() {
        _movies = _movies;
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _currentPage++;

    if (_currentPage < _totalPage && !_isLoading) {
      List<Movie> movies = await _getTrendingMovies();

      if (mounted) {
        setState(() => _movies.addAll(movies));
      }
    }
    _refreshController.loadComplete();
  }

  Future _getTrendingMovies({String time = 'day'}) async {
    _isLoading = true;
    try {
      Response response = await apiClient.get(
        '/3/trending/movie/$time',
        queryParameters: {"page": _currentPage},
      );

      final data = response.data;
      final results = data["results"] as List;
      _totalPage = data["total_pages"];
      List<Movie> movies = [];
      results.forEach((r) => movies.add(Movie.fromJson(r)));

      return movies;
    } on DioError catch (err) {
      throw err;
    } finally {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scrollbar(
      child: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: ClassicHeader(
          failedIcon: const Icon(Icons.error, color: Colors.white),
          completeIcon: const Icon(Icons.done, color: Colors.white),
          idleIcon: const Icon(Icons.arrow_downward, color: Colors.white),
          releaseIcon: const Icon(Icons.refresh, color: Colors.white),
          textStyle: TextStyle(color: Colors.white),
        ),
        footer: ClassicFooter(
          failedIcon: const Icon(Icons.error, color: Colors.white),
          canLoadingIcon: const Icon(Icons.autorenew, color: Colors.white),
          idleIcon: const Icon(Icons.arrow_upward, color: Colors.white),
          textStyle: TextStyle(color: Colors.white),
        ),
        child: ListView.builder(
          itemExtent: 200.0,
          itemCount: _movies.length,
          itemBuilder: (_, int index) {
            Movie movie = _movies[index];
            return MovieItem(movie);
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
