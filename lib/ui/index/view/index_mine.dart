import 'package:feeling/ui/story/story_screen.dart';
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
import '../../../data/box/story_box.dart';

class IndexMine extends StatefulWidget {
  @override
  _IndexMineState createState() => _IndexMineState();
}

class _IndexMineState extends State<IndexMine>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int storyIndex = ModalRoute.of(context).settings.arguments ?? 0;
    final storyBox = Hive.box<Story>(StoryBox.name);
    double _height = 500.0;
    double _width = screenWidth(context) - 90;

    print(storyIndex);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: _height,
          child: storyBox.isNotEmpty
              ? Swiper(
                  loop: false,
                  index: storyIndex,
                  layout: SwiperLayout.STACK,
                  itemCount: storyBox.length,
                  itemWidth: _width,
                  itemHeight: _height,
                  containerWidth: _width,
                  containerHeight: _height,
                  itemBuilder: (BuildContext context, int index) {
                    Story story = storyBox.getAt(index);
                    Movie movie = story.movie;
                    final poster = movie.posterPath ?? movie.backdropPath;

                    final feel = story.feel;
                    final asset = FeelEmoji.list
                        .firstWhere((item) => item['label'] == feel);
                    final svg = asset['svg'];
                    final label = asset['label'];

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
                          ExtendedImage.network(
                            IMG_PREFIX + poster,
                            fit: BoxFit.cover,
                            cache: true,
                            height: 250.0,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          Positioned(
                            top: 12.0,
                            left: 24.0,
                            child: Text(story.watchDate, style: Styles.normal),
                          ),
                          Positioned(
                            top: 12.0,
                            right: 24.0,
                            child: Text(
                              story.rate.toStringAsFixed(1),
                              style: Styles.normal,
                            ),
                          ),
                          Positioned(
                            right: 24.0,
                            bottom: 24.0,
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              child:
                                  SvgPicture.asset(svg, semanticsLabel: label),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                  'No story now...',
                  style: Styles.subTitle,
                )),
        ),
      ],
    );
  }
}
