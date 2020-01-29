import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../model/story.dart';
import '../../../const/api_const.dart';
import '../../../model/movie.dart';
import '../../../data/box/story_box.dart';

class IndexMine extends StatefulWidget {
  @override
  _IndexMineState createState() => _IndexMineState();
}

class _IndexMineState extends State<IndexMine> {
  @override
  Widget build(BuildContext context) {
    final storyBox = Hive.box<Story>(StoryBox.name);

    return Column(
      children: <Widget>[
        Container(
          height: 500.0,
          child: Swiper(
            scale: 0.9,
            viewportFraction: .8,
            itemCount: storyBox.length,
            itemBuilder: (BuildContext context, int index) {
              Story story = storyBox.getAt(index);
              Movie movie = story.movie;
              final poster = movie.posterPath ?? movie.backdropPath;

              return ExtendedImage.network(
                IMG_PREFIX + poster,
                fit: BoxFit.cover,
                cache: true,
                height: 250.0,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              );
            },
            // layout: SwiperLayout.STACK,
          ),
        ),
      ],
    );
  }
}
