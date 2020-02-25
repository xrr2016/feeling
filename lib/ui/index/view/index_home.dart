import 'package:Feeling/data/network/tmdb.dart';
import 'package:Feeling/ui/index/provider/trending_provider.dart';
import 'package:Feeling/ui/index/widget/movie_item.dart';
import 'package:Feeling/ui/search/search_delegate.dart';
import 'package:Feeling/utils/screen_size.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/movie.dart';
import '../../../widget/loading.dart';
import '../../../data/network/api_client.dart';
import '../../../data/network/tmdb.dart';

class IndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  Tmdb tmdb = Tmdb();

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
        options: buildCacheOptions(Duration(days: 1)),
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

  List<String> _titles = ['Popular', 'Playing', 'Upcoming', 'Trending', 'Top'];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _getMovies(type: 'popular', page: _popularCurrent);
    // _getMovies(type: 'upcoming', page: _upcomingCurrent);
    // _getMovies(type: 'now_playing', page: _playingCurrent);
    // _getMovies(type: 'top_rated', page: _topCurrent);

    // tmdb.getMovies(query: {"page": 1}).then((value) {
    //   print(value);
    // });

    _tabController = TabController(
      length: _titles.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        title: TabBar(
          isScrollable: true,
          indicatorWeight: 0.5,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 22.0),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _titles.map((String name) => Tab(text: name)).toList(),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: AppSearchDelegate(),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _titles.map((String name) => Tab(text: name)).toList(),
      ),
    );

    // if (_isLoadingData) {
    //   return Loading();
    // } else {
    //   return Consumer<TrendingProvider>(
    //     builder: (context, trending, _) {
    //       return Scrollbar(
    //         child: ListView.builder(
    //           itemExtent: 200.0,
    //           itemCount: _popular.length,
    //           itemBuilder: (_, int index) => MovieItem(_popular[index]),
    //         ),
    //       );
    //     },
    //   );
    // }
  }

  @override
  bool get wantKeepAlive => true;
}

// RefreshIndicator(
//   color: Colors.white,
//   backgroundColor: Colors.transparent,
//   onRefresh: () {
//     _isLoadingData = false;
//     _isLoadingMovies = false;

//     _popularCurrent = 1;
//     _popularTotal = 1;

//     _upcomingCurrent = 1;
//     _upcomingTotal = 1;

//     _playingCurrent = 1;
//     _playingTotal = 1;

//     _topCurrent = 1;
//     _topTotal = 1;

//     setState(() {
//       _popular = [];
//       _upcoming = [];
//       _playing = [];
//       _top = [];
//     });

//     return _fetchAllMovies();
//   },
// child: ListView(
// children: <Widget>[
// NotificationListener<ScrollNotification>(
//   child: MovieListHorizontal(_popular, 'Popular'),
//   onNotification: (ScrollNotification scrollInfo) {
//     final metrics = scrollInfo.metrics;

//     if (metrics.pixels >= metrics.maxScrollExtent) {
//       if (_popularCurrent < _popularTotal && !_isLoadingMovies) {
//         _popularCurrent++;
//         _getMovies(type: 'popular', page: _popularCurrent);
//       }
//     }
//     return;
//   },
// ),
// NotificationListener<ScrollNotification>(
//   child: MovieListHorizontal(_playing, 'Playing'),
//   onNotification: (ScrollNotification scrollInfo) {
//     final metrics = scrollInfo.metrics;

//     if (metrics.pixels >= metrics.maxScrollExtent) {
//       if (_playingCurrent < _playingTotal && !_isLoadingMovies) {
//         _playingCurrent++;
//         _getMovies(type: 'now_playing', page: _playingCurrent);
//       }
//     }
//     return;
//   },
// ),
// NotificationListener<ScrollNotification>(
//   child: MovieListHorizontal(_upcoming, 'Upcoming'),
//   onNotification: (ScrollNotification scrollInfo) {
//     final metrics = scrollInfo.metrics;

//     if (metrics.pixels >= metrics.maxScrollExtent) {
//       if (_upcomingCurrent < _upcomingTotal && !_isLoadingMovies) {
//         _upcomingCurrent++;
//         _getMovies(type: 'upcoming', page: _upcomingCurrent);
//       }
//     }
//     return;
//   },
// ),
// NotificationListener<ScrollNotification>(
//   child: MovieListHorizontal(_top, 'Top'),
//   onNotification: (ScrollNotification scrollInfo) {
//     final metrics = scrollInfo.metrics;

//     if (metrics.pixels >= metrics.maxScrollExtent) {
//       if (_topCurrent < _topTotal && !_isLoadingMovies) {
//         _topCurrent++;
//         _getMovies(type: 'top_rated', page: _topCurrent);
//       }
//     }
//     return;
//   },
// ),
//   ],
// ),
// );
