import 'package:Feeling/model/movie.dart';
import 'package:Feeling/service/tmdb.dart';
import 'package:Feeling/ui/index/widget/movie_item_explore.dart';
import 'package:Feeling/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExploreMovieList extends StatefulWidget {
  final String movieType;

  const ExploreMovieList({@required this.movieType});

  @override
  _ExploreMovieListState createState() => _ExploreMovieListState();
}

class _ExploreMovieListState extends State<ExploreMovieList>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPage = 1;
  List<Movie> _movies = [];

  void _clear() {
    _currentPage = 1;
    _totalPage = 1;
    _movies.clear();
    _isLoading = false;
  }

  Future _getMovies() async {
    Map result = await Tmdb.getMovies(
      type: widget.movieType,
      query: {'page': _currentPage},
    );

    setState(() {
      _movies.addAll(result['movies']);
      _totalPage = result['total'];
    });
  }

  Future _loadMoreMovies() async {
    _currentPage++;

    if (_currentPage < _totalPage && !_isLoading) {
      await _getMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: () async {
                _clear();
                await _getMovies();
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await _loadMoreMovies();
                _refreshController.loadComplete();
              },
              child: _movies.isEmpty
                  ? Center(child: AssetLogo())
                  : ListView.builder(
                      itemExtent: 280.0,
                      padding: const EdgeInsets.all(12.0),
                      itemCount: _movies.length,
                      itemBuilder: (_, int index) => MovieItemExplore(
                        _movies[index],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
