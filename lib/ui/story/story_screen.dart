import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles.dart';
import '../../model/movie.dart';
import '../../utils/screen_size.dart';
import '../../ui/movie/movie_screen.dart';
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

    return Scaffold(
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topLeft,
        children: <Widget>[
          ExtendedImage.network(
            IMG_PREFIX_HD + poster,
            cache: true,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 2),
              padding: EdgeInsets.only(left: 24.0, top: 24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black26,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MovieScreen(movie, movie.id.toString()),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            movie.title,
                            style: Styles.title.copyWith(
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: StoryInfoItem('Review:', story.review),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 70.0, child: Text(labal, style: Styles.normal)),
          SizedBox(width: 12.0),
          Expanded(child: Text(content, style: Styles.subTitle)),
        ],
      ),
    );
  }
}
