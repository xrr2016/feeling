import 'package:flin/ui/index/widget/movie_item.dart';
import 'package:flin/ui/index/widget/person_item.dart';
import 'package:flin/ui/index/widget/tv_item.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../model/tv.dart';
import '../../../model/person.dart';
import '../../../model/movie.dart';
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

  Future _getTrendingList({String type = 'all', String time = 'day'}) async {
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
        final String mediaType = item['media_type'];

        switch (mediaType) {
          case 'movie':
            _medias.add(Movie.fromJson(item));
            break;
          case 'tv':
            _medias.add(Tv.fromJson(item));
            break;
          case 'person':
            _medias.add(Person.fromJson(item));
            break;
        }
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
    _getTrendingList();
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
            ? Scrollbar(
                child: Padding(
                  child: ListView.builder(
                    itemCount: _medias.length,
                    itemBuilder: (_, int index) {
                      var item = _medias[index];

                      switch (item.mediaType) {
                        case 'movie':
                          return MovieItem(item);
                        case 'tv':
                          return TvItem(item);
                        case 'person':
                          return PersonItem(item);
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

//DropdownButton<String>(
//value: dropdownValue,
//onChanged: (String val) {
//setState(() {
//dropdownValue = newValue;
//});
//},
//items: <String>['One', 'Two', 'Free', 'Four']
//.map<DropdownMenuItem<String>>((String value) {
//return DropdownMenuItem<String>(
//value: value,
//child: Text(value),
//);
//}).toList(),
//),
