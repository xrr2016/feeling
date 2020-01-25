import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../styles.dart';
import '../../model/cast.dart';
import '../../model/movie.dart';
import '../../widget/star_rating.dart';
import '../../const/api_const.dart';
import '../../utils/screen_size.dart';
import '../../ui/edit/edit_screen.dart';
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
  bool _isLoadingImages = false;

  List _casts = [];

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

  Future _getMovieImages(int id) async {
    _isLoadingImages = true;
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
    } finally {
      _isLoadingImages = false;
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
//    _getMovieVideos(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;
    String poster = movie.posterPath ?? movie.backdropPath;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
//            actions: <Widget>[
//              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
//            ],
            expandedHeight: screenHeight(context, reducedBy: 300),
            flexibleSpace: FlexibleSpaceBar(
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
                top: 12.0,
                left: 12.0,
                right: 12.0,
                bottom: 60.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 12.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(movie.title, style: Styles.title),
                            SizedBox(height: 6.0),
                            Row(
                              children: <Widget>[
                                StarRating(movie.voteAverage),
                                SizedBox(width: 12.0),
                                Text(
                                  movie.voteAverage.toString(),
                                  style:
                                      Styles.info.copyWith(color: Colors.amber),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                  Row(
                    children: <Widget>[
                      Text('Overview', style: Styles.subTitle),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    movie.overview,
                    style: Styles.normal,
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      Text('Gallery', style: Styles.subTitle),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(
                    height: 160.0,
                    child: ListView.builder(
                      itemExtent: 224.0,
                      itemCount: _gallery.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        String path = _gallery[index];

                        return Container(
                          width: 200.0,
                          height: 160.0,
                          margin: EdgeInsets.only(right: 12.0),
                          child: ExtendedImage.network(
                            IMG_PREFIX + path,
                            fit: BoxFit.cover,
                            cache: true,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      Text('Cast', style: Styles.subTitle),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(
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
                  ),
                ],
              ),
            ),
          )
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
