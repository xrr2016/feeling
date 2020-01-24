import 'package:flutter/material.dart';

import '../../../model/movie.dart';
import '../../../const/api_const.dart';
import '../../../widget/place_holder.dart';
import '../../movie/movie_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final img = movie.posterPath ?? movie.backdropPath;

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MovieScreen(movie)),
          );
        },
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
