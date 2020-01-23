import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../model/tv.dart';
import '../../../model/person.dart';
import '../../../model/movie.dart';
import '../widget/media_item.dart';
import '../../../widget/loading.dart';
import '../../../data/network/api_client.dart';

class IndexTrending extends StatefulWidget {
  @override
  _IndexTrendingState createState() => _IndexTrendingState();
}

class _IndexTrendingState extends State<IndexTrending> {
  bool _isLoadingData = false;
  int _currentPage = 1;
  int _totalPage = 1;
  double _itemExtent = 600.0;

  List _medias = [];

  Future _getTrendingList() async {
    _isLoadingData = true;
    try {
      Response response = await apiClient.get(
        '/3/trending/all/day',
        queryParameters: {
          "page": _currentPage,
        },
      );

      final data = response.data;
      final results = data["results"] as List;
      _totalPage = data["total_pages"];

      results.forEach((item) {
        print(item['media_type']);
      });

//    _medias.add(Media.fromJson(item))
      setState(() => _medias = _medias);
    } on DioError catch (err) {
      throw err;
    } finally {
      _isLoadingData = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getTrendingList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        _currentPage = 1;
        setState(() {
          _medias = [];
        });

        return _getTrendingList();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          final metrics = scrollInfo.metrics;

          if (metrics.pixels >= metrics.maxScrollExtent) {
            if (_currentPage < _totalPage && !_isLoadingData) {
              _currentPage++;
              _getTrendingList();
            }
          }
          return;
        },
        child: _medias.isNotEmpty
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemExtent: _itemExtent,
                        itemCount: _medias.length,
                        itemBuilder: (_, int index) {
                          return MediaItem(media: _medias[index]);
                        },
                        physics: AlwaysScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              )
            : Loading(),
      ),
    );
  }
}
