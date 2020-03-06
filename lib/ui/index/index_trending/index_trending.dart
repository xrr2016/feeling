import 'package:Feeling/ui/index/widget/movie_item_trending.dart';
import 'package:Feeling/ui/search/search_delegate.dart';
import 'package:Feeling/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import './trending_provider.dart';

class IndexTrending extends StatefulWidget {
  @override
  _IndexTrendingState createState() => _IndexTrendingState();
}

class _IndexTrendingState extends State<IndexTrending>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierProvider(
      create: (context) => TrendingProvider(),
      child: Consumer<TrendingProvider>(
        builder: (context, trending, _) {
          return Column(
            children: <Widget>[
              AppBar(
                elevation: 0.0,
                centerTitle: false,
                title: PopupMenuButton(
                  child: Text(
                    trending.time == 'week' ? 'Weekily' : 'Daily',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize,
                    ),
                  ),
                  onSelected: (String result) {
                    setState(() {
                      trending.setTime(result);
                    });
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: "day",
                      child: Text('Daily'),
                    ),
                    const PopupMenuItem<String>(
                      value: "week",
                      child: Text('Weekily'),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Center(
                    child: IconButton(
                      tooltip: 'Search',
                      icon: const Icon(Icons.search),
                      onPressed: () => showSearch(
                        context: context,
                        delegate: AppSearchDelegate(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Expanded(
                child: Scrollbar(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: () async {
                      await trending.refreshTrendingMovies();
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await trending.loadMoreMovies();
                      _refreshController.loadComplete();
                    },
                    child: trending.movies.isEmpty
                        ? Center(child: AssetLogo())
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            itemCount: trending.movies.length,
                            itemBuilder: (_, int index) => Column(
                              children: <Widget>[
                                MovieItemTrennding(
                                  movie: trending.movies[index],
                                ),
                                SizedBox(height: 12.0),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
