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

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieScreen(movie)),
        );
      },
      child: Container(
        height: 180.0,
        margin: EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 120.0,
              height: 132.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Hero(
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
