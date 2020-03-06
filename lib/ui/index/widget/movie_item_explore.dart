import 'package:Feeling/ui/movie/movie_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../model/movie.dart';
import '../../../const/api_const.dart';
import '../../../widget/star_rating.dart';

class MovieItemExplore extends StatefulWidget {
  final Movie movie;

  const MovieItemExplore(this.movie);

  @override
  _MovieItemExploreState createState() => _MovieItemExploreState();
}

class _MovieItemExploreState extends State<MovieItemExplore> {
  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.movie;
    final String poster = movie.posterPath ?? movie.backdropPath;

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieScreen(movie, movie.id.toString()),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Hero(
                tag: movie.id.toString(),
                child: ExtendedImage.network(
                  IMG_PREFIX + poster,
                  cache: true,
                  fit: BoxFit.cover,
                  width: 180.0,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 6.0),
                  Text(
                    movie.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: <Widget>[
                      StarRating(movie.voteAverage),
                      SizedBox(width: 12.0),
                      Text(
                        movie.voteAverage.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.amber),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(movie?.releaseDate),
                  SizedBox(height: 12.0),
                  Text(
                    movie?.overview,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.body2.fontSize,
                    ),
                    overflow: TextOverflow.ellipsis,
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
