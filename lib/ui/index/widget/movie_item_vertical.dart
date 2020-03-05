import 'package:Feeling/service/tmdb.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

import '../../../model/movie.dart';
import '../../movie/movie_screen.dart';

class MovieItemVertical extends StatelessWidget {
  final Movie movie;
  final String label;

  const MovieItemVertical({this.movie, this.label});

  @override
  Widget build(BuildContext context) {
    final tag = '$label${movie.id}';
    final poster = movie.posterPath ?? movie.backdropPath;

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MovieScreen(movie, tag)),
          );
        },
        child: Column(
          children: <Widget>[
            Hero(
              tag: tag,
              child: ExtendedImage.network(
                Tmdb.imgNormal + poster,
                shape: BoxShape.rectangle,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 420.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                cache: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movie.title,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                Theme.of(context).textTheme.title.fontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          movie.releaseDate,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize:
                                Theme.of(context).textTheme.title.fontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.amber,
                      ),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: Text(
                      movie.voteAverage.toString(),
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: Theme.of(context).textTheme.title.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
