import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../../const/api_const.dart';
import '../../../widget/place_holder.dart';
import '../../movie/movie_screen.dart';
import '../../../widget/star_rating.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final img = movie.posterPath ?? movie.backdropPath;

    double _maxWidth = MediaQuery.of(context).size.width * 0.5;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieScreen(movie)),
        );
      },
      child: Container(
        height: 180.0,
        margin: EdgeInsets.only(
          bottom: 12.0,
          top: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  fadeInCurve: Curves.ease,
                  image: NetworkImage(IMG_PREFIX + img),
                  placeholder: placeholder,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: _maxWidth,
                  ),
                  child: Text(
                    movie.title,
                    style: Styles.subTitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: _maxWidth,
                  ),
                  child: Text(
                    movie.overview,
                    style: Styles.info.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
