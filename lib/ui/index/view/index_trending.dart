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
  RefreshController _refreshController = RefreshController(
      // initialRefresh: true,
      );

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Movie> movies = Provider.of<TrendingProvider>(context).movies;

    return Scrollbar(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onLoading: () async {
          await Provider.of<TrendingProvider>(context, listen: false)
              .loadMoreMovies();
          _refreshController.loadComplete();
        },
        child: ListView.builder(
          itemExtent: 200.0,
          itemCount: movies.length,
          itemBuilder: (_, int index) {
            Movie movie = movies[index];
            return MovieItem(movie);
          },
        ),
      ),
    );

    // return Scrollbar(
    //   child: SmartRefresher(
    //     enablePullUp: true,
    //     enablePullDown: true,
    //     controller: _refreshController,
    //     onRefresh: _onRefresh,
    //     onLoading: _onLoading,
    //     header: ClassicHeader(
    //       failedIcon: const Icon(Icons.error, color: Colors.white),
    //       completeIcon: const Icon(Icons.done, color: Colors.white),
    //       idleIcon: const Icon(Icons.arrow_downward, color: Colors.white),
    //       releaseIcon: const Icon(Icons.refresh, color: Colors.white),
    //       textStyle: TextStyle(color: Colors.white),
    //     ),
    //     footer: ClassicFooter(
    //       failedIcon: const Icon(Icons.error, color: Colors.white),
    //       canLoadingIcon: const Icon(Icons.autorenew, color: Colors.white),
    //       idleIcon: const Icon(Icons.arrow_upward, color: Colors.white),
    //       textStyle: TextStyle(color: Colors.white),
    //     ),
    //     child: ListView.builder(
    //       itemExtent: 200.0,
    //       itemCount: _movies.length,
    //       itemBuilder: (_, int index) {
    //         Movie movie = _movies[index];
    //         return MovieItem(movie);
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
