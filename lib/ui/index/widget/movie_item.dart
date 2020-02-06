import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../../const/api_const.dart';
import '../../movie/movie_screen.dart';
import '../../../widget/star_rating.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;

  const MovieItem(this.movie);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final poster = widget.movie.posterPath ?? widget.movie.backdropPath;

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  MovieScreen(widget.movie, widget.movie.id.toString()),
            ),
          );
        },
        child: Container(
          height: 200.0,
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: widget.movie.id.toString(),
                child: ExtendedImage.network(
                  IMG_PREFIX + poster,
                  cache: true,
                  width: 120.0,
                  height: 132.0,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      widget.movie.title,
                      maxLines: 1,
                      style: Styles.normal.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      children: <Widget>[
                        StarRating(widget.movie.voteAverage),
                        SizedBox(width: 12.0),
                        Text(
                          widget.movie.voteAverage.toString(),
                          style: Styles.info.copyWith(color: Colors.amber),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      widget.movie.overview,
                      maxLines: 3,
                      style: Styles.info,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
