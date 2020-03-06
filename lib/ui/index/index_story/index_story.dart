import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../styles.dart';
import '../../../const/feel_emoji.dart';
import '../../../utils/screen_size.dart';
import '../../../model/story.dart';
import '../../../const/api_const.dart';
import '../../../model/movie.dart';
import '../../../ui/story/story_screen.dart';
import '../../../data/box/story_box.dart';

class IndexStory extends StatefulWidget {
  @override
  _IndexStoryState createState() => _IndexStoryState();
}

class _IndexStoryState extends State<IndexStory>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int storyIndex = ModalRoute.of(context).settings.arguments ?? 0;
    final storys = Hive.box<Story>(StoryBox.name).values.toList().reversed;
    double _height = screenHeight(context, dividedBy: 1.8);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: storys.isNotEmpty
              ? Swiper(
                  loop: false,
                  scale: 0.9,
                  index: storyIndex,
                  viewportFraction: 0.8,
                  itemCount: storys.length,
                  itemBuilder: (BuildContext context, int index) {
                    Story story = storys.elementAt(index);
                    Movie movie = story.movie;
                    final poster = movie.posterPath ?? movie.backdropPath;

                    final feel = story.feel;
                    final asset = FeelEmoji.list
                        .firstWhere((item) => item['label'] == feel);
                    final svg = asset['svg'];
                    final label = asset['label'];

                    final image = ExtendedImage.network(
                      IMG_PREFIX_HD + poster,
                      fit: BoxFit.cover,
                      cache: true,
                      height: 250.0,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    );

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoryScreen(story),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          image,
                          Positioned(
                            top: 12.0,
                            right: 12.0,
                            child: Container(
                              width: 32.0,
                              height: 32.0,
                              child:
                                  SvgPicture.asset(svg, semanticsLabel: label),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(child: Text('No story now...', style: Styles.subTitle)),
        ),
      ],
    );
  }
}
