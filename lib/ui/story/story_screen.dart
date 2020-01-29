import 'package:feeling/styles.dart';
import 'package:flutter/material.dart';

import '../../model/movie.dart';
import '../../model/story.dart';
import '../../const/api_const.dart';

class StoryScreen extends StatefulWidget {
  final Story story;

  const StoryScreen(this.story);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final Movie movie = story.movie;
    String poster = movie.posterPath ?? movie.backdropPath;

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(IMG_PREFIX + poster),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            Text(
              story.rate.toStringAsFixed(1),
              style: Styles.normal,
            ),
          ],
        ),
      ),
    );
  }
}
