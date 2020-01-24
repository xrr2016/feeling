import 'package:flin/ui/edit/edit_screen.dart';
import 'package:flutter/material.dart';

import '../../model/movie.dart';
import '../../const/api_const.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen(this.movie);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Hero(
        tag: movie.id,
        child: Image.network(
          IMG_PREFIX + movie.posterPath,
          fit: BoxFit.cover,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditScreen(movie)),
            );
          },
        ),
      ),
    );
  }
}
