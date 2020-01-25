import 'dart:math';

import 'package:flin/const/api_const.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../movie/movie_screen.dart';
import '../../../widget/place_holder.dart';
import '../../../widget/star_rating.dart';

class MovieItemVertical extends StatelessWidget {
  const MovieItemVertical(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final poster = movie.posterPath ?? movie.backdropPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieScreen(movie)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 250.0,
              margin: EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Hero(
                tag: movie.id + Random().nextInt(100),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    fadeInCurve: Curves.ease,
                    image: NetworkImage(IMG_PREFIX + poster),
                    placeholder: placeholder,
                  ),
                ),
              ),
            ),
            Text(
              movie.title,
              maxLines: 1,
              style: Styles.normal,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6.0),
            Row(
              children: <Widget>[
                StarRating(movie.voteAverage),
                SizedBox(width: 12.0),
                Text(
                  movie.voteAverage.toString(),
                  style: Styles.info.copyWith(color: Colors.amber),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
