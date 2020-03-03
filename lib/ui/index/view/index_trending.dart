import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../styles.dart';
import '../provider/trending_provider.dart';
import '../../../ui/index/widget/movie_item.dart';

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

    const failedIcon = const Icon(Icons.error, color: Colors.white);
    const completeIcon = const Icon(Icons.done, color: Colors.white);
    const idleIcon = const Icon(Icons.arrow_downward, color: Colors.white);
    const textStyle = TextStyle(color: Colors.white);

    return Consumer<TrendingProvider>(
      builder: (context, trending, _) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Scrollbar(
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
                      header: ClassicHeader(
                        failedIcon: failedIcon,
                        completeIcon: completeIcon,
                        idleIcon: idleIcon,
                        textStyle: textStyle,
                        releaseIcon:
                            const Icon(Icons.refresh, color: Colors.white),
                      ),
                      footer: ClassicFooter(
                        failedIcon: failedIcon,
                        idleIcon: idleIcon,
                        textStyle: textStyle,
                        canLoadingIcon:
                            const Icon(Icons.autorenew, color: Colors.white),
                      ),
                      child: ListView.builder(
                        itemExtent: 200.0,
                        itemCount: trending.movies.length,
                        itemBuilder: (_, int index) =>
                            MovieItem(trending.movies[index]),
                      ),
                    ),
                  ),
                  trending.isLoading
                      ? Positioned(
                          top: 0.0,
                          right: 12.0,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              '${trending.currentPage}/${trending.totalPage}',
                              style: Styles.info,
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Text(trending.message),
                        ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
