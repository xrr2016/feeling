import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../../const/api_const.dart';
import '../../movie/movie_screen.dart';
import '../../../widget/star_rating.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final poster = movie.posterPath ?? movie.backdropPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieScreen(
              movie,
              movie.id.toString(),
            ),
          ),
        );
      },
      child: Container(
        height: 160.0,
        margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: movie.id.toString(),
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
            SizedBox(width: 24.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    movie.title,
                    maxLines: 1,
                    style: Styles.normal,
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
                  Spacer(),
                  Text(
                    movie.overview,
                    maxLines: 4,
                    style: Styles.info,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
