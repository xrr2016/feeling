import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../styles.dart';
import '../../widget/text_tag.dart';
import '../../model/cast.dart';
import '../../model/movie.dart';
import '../../widget/star_rating.dart';
import '../../const/api_const.dart';
import '../../utils/screen_size.dart';
import '../../ui/edit/edit_screen.dart';
import '../../model/movie_detail.dart';
import '../../data/network/api_client.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;
  final String heroTag;

  const MovieScreen(this.movie, this.heroTag);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List _gallery = [];
  List _casts = [];
  MovieDetail _movieDetail;

//  List _videos = [];
//  bool _isLoadingVideos = false;
//
//  Future _getMovieVideos(int id) async {
//    _isLoadingVideos = true;
//    try {
//      Response response = await ApiClient.get('/3/movie/$id/videos');
//
//      final data = response.data;
//      final results = data["results"] as List;
//
//      results.forEach((r) {
//        if (r['site'] == 'YouTube') {
//          _videos.add(r['id']);
//        }
//      });
//
//      setState(() {
//        _videos = _videos;
//      });
//
//      return _videos;
//    } on DioError catch (err) {
//      throw err;
//    } finally {
//      _isLoadingVideos = false;
//    }
//  }

  Future _getMovieDetail(int id) async {
    try {
      Response response = await ApiClient.get('/3/movie/$id');

      final data = response.data;

      if (!mounted) return;
      setState(() {
        _movieDetail = MovieDetail.fromJson(data);
      });
    } on DioError catch (err) {
      throw err;
    }
  }

  Future _getMovieImages(int id) async {
    try {
      Response response = await ApiClient.get('/3/movie/$id/images');

      final data = response.data;
      final backdrops = data["backdrops"] as List;

      backdrops.forEach((r) => _gallery.add(r['file_path']));

      if (!mounted) return;
      setState(() {
        _gallery = _gallery;
      });
    } on DioError catch (err) {
      throw err;
    }
  }

  Future _getMovieCast(int id) async {
    try {
      Response response = await ApiClient.get('/3/movie/$id/credits');

      final data = response.data;
      final result = data["cast"] as List;

      result.forEach((r) => _casts.add(Cast.fromJson(r)));

      if (!mounted) return;
      setState(() {
        _casts = _casts;
      });
    } on DioError catch (err) {
      throw err;
    }
  }

//  void listener() {
//    if (_isPlayerReady && mounted && !_videoController.value.isFullScreen) {
//      setState(() {
//        _videoMetaData = _videoController.metadata;
//        _playerState = _videoController.value.playerState;
//      });
//    }
//  }

  @override
  void initState() {
    super.initState();
    Movie movie = widget.movie;

    _getMovieImages(movie.id);
    _getMovieCast(movie.id);
    _getMovieDetail(movie.id);
//    _getMovieVideos(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;
    String poster = movie.posterPath ?? movie.backdropPath;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
//            actions: <Widget>[
//              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
//            ],
            expandedHeight: screenHeight(context, dividedBy: 2),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: ExtendedImage.network(
                IMG_PREFIX + poster,
                cache: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 12.0, bottom: 60.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 12.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movie.title,
                              style: Styles.subTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6.0),
                            Text(movie.releaseDate, style: Styles.info),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            movie.voteAverage.toString(),
                            style:
                                Styles.subTitle.copyWith(color: Colors.amber),
                          ),
                          SizedBox(height: 6.0),
                          StarRating(movie.voteAverage),
                        ],
                      ),
//                      IconButton(
//                        iconSize: 60.0,
//                        onPressed: () {
//                          if (_videoController.value.isPlaying) {
//                            _videoController.pause();
//                          } else {
//                            _videoController.play();
//                          }
//                        },
//                        color: Colors.redAccent,
//                        icon: Icon(Icons.play_circle_outline),
//                      )
                    ],
                  ),
                  SizedBox(height: 24.0),
                  _movieDetail == null
                      ? SizedBox(height: 36.0)
                      : Row(
                          children: <Widget>[
                            Wrap(
                              spacing: 12.0,
                              verticalDirection: VerticalDirection.down,
                              direction: Axis.horizontal,
                              children: _movieDetail.genres
                                  .map((g) => TextTag(g.name))
                                  .toList(),
                            ),
                          ],
                        ),
                  SizedBox(height: 12.0),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 12.0),
                      Row(
                        children: <Widget>[
                          Text('Overview', style: Styles.subTitle),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Text(movie.overview, style: Styles.normal),
                      SizedBox(height: 12.0),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: <Widget>[
                      Text('Gallery', style: Styles.subTitle),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  GalleryList(gallery: _gallery),
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      Text('Cast', style: Styles.subTitle),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  CastList(casts: _casts),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditScreen(movie)),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class CastList extends StatelessWidget {
  const CastList({
    Key key,
    @required List casts,
  })  : _casts = casts,
        super(key: key);

  final List _casts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        itemExtent: 92.0,
        itemCount: _casts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          Cast cast = _casts[index];
          String profile = cast.profilePath ?? '';

          return Container(
            width: 80.0,
            height: 80.0,
            margin: EdgeInsets.only(right: 12.0),
            child: ExtendedImage.network(
              IMG_PREFIX + profile,
              fit: BoxFit.cover,
              cache: true,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}

class GalleryList extends StatelessWidget {
  const GalleryList({
    Key key,
    @required List gallery,
  })  : _gallery = gallery,
        super(key: key);

  final List _gallery;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: ListView.builder(
        itemExtent: 224.0,
        itemCount: _gallery.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          String path = _gallery[index];

          return Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: ExtendedImage.network(
              IMG_PREFIX + path,
              cache: true,
              fit: BoxFit.cover,
              width: 200.0,
              height: 160.0,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          );
        },
      ),
    );
  }
}
