import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles.dart';
import '../../model/movie.dart';
import '../../model/story.dart';
import '../../const/api_const.dart';
import '../../const/feel_emoji.dart';

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

    final feel = story.feel;
    final asset = FeelEmoji.list.firstWhere((item) => item['label'] == feel);
    final svg = asset['svg'];
    final label = asset['label'];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: Styles.background,
        image: DecorationImage(
          image: NetworkImage(IMG_PREFIX + poster),
          // image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 24.0,
              bottom: 100.0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 70.0,
                            child: Text('Feel:', style: Styles.normal),
                          ),
                          SizedBox(width: 6.0),
                          Container(
                            width: 50.0,
                            height: 50.0,
                            child: SvgPicture.asset(svg, semanticsLabel: label),
                          ),
                        ],
                      ),
                    ),
                    StoryInfoItem('Rate:', story.rate.toStringAsFixed(1)),
                    StoryInfoItem('Date:', story.watchDate),
                    StoryInfoItem('Review:', story.review),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryInfoItem extends StatelessWidget {
  final String labal;
  final String content;

  const StoryInfoItem(this.labal, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 70.0, child: Text(labal, style: Styles.normal)),
          SizedBox(width: 12.0),
          Text(content, style: Styles.subTitle),
        ],
      ),
    );
  }
}
