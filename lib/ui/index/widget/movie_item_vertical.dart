import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../movie/movie_screen.dart';
import '../../../const/api_const.dart';
import '../../../widget/star_rating.dart';

class MovieItemVertical extends StatelessWidget {
  final Movie movie;
  final String label;

  const MovieItemVertical(this.movie, this.label);

  @override
  Widget build(BuildContext context) {
    final tag = '$label${movie.id}';
    final poster = movie.posterPath ?? movie.backdropPath;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieScreen(movie, tag)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: tag,
              child: ExtendedImage.network(
                IMG_PREFIX + poster,
                fit: BoxFit.cover,
                cache: true,
                height: 250.0,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              movie.title,
              maxLines: 1,
              style: Styles.normal,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 12.0),
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
