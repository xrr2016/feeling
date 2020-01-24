import 'package:flin/ui/index/widget/person_item.dart';
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

class _IndexTrendingState extends State<IndexTrending>
    with AutomaticKeepAliveClientMixin {
  bool _isLoadingData = false;
  int _currentPage = 1;
  int _totalPage = 1;

  List _medias = [];

  Future _getTrendingList(String type, String time) async {
    _isLoadingData = true;
    try {
      Response response = await ApiClient.get(
        '/3/trending/$type/$time',
        queryParameters: {
          "page": _currentPage,
        },
      );

      final data = response.data;
      final results = data["results"] as List;
      _totalPage = data["total_pages"];

      results.forEach((item) {
        var media;
        final String mediaType = item['media_type'];

        switch (mediaType) {
          case 'movie':
            media = Movie.fromJson(item);
            break;
          case 'tv':
            media = Tv.fromJson(item);
            break;
          case 'person':
            media = Person.fromJson(item);
            break;
        }
        _medias.add(media);
      });

      setState(() {
        _medias = _medias;
      });
    } on DioError catch (err) {
      throw err;
    } finally {
      _isLoadingData = false;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTrendingList('person', 'week');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      backgroundColor: Colors.transparent,
      onRefresh: () {
        _currentPage = 1;
        _totalPage = 1;

        setState(() {
          _medias = [];
        });

        return _getTrendingList('person', 'week');
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          final metrics = scrollInfo.metrics;

          if (metrics.pixels >= metrics.maxScrollExtent) {
            if (_currentPage < _totalPage && !_isLoadingData) {
              _currentPage++;
              _getTrendingList('person', 'week');
            }
          }
          return;
        },
        child: _medias.isNotEmpty
            ? Scrollbar(
                child: Padding(
                  child: ListView.builder(
                    itemCount: _medias.length,
                    itemBuilder: (_, int index) {
                      var media = _medias[index];

                      switch (media.mediaType) {
                        case 'movie':
                          return MediaItem(item: _medias[index]);
                        case 'tv':
                          return MediaItem(item: _medias[index]);
                        case 'person':
                          return PersonItem(media);
                          break;
                        default:
                          return null;
                      }
                    },
                    physics: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                ),
              )
            : Loading(),
      ),
    );
  }
}
