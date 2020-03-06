import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../styles.dart';
import '../../../const/feel_emoji.dart';
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

    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Story'),
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.settings),
            //   onPressed: () {
            //     Navigator.pushNamed(context, SettingScreen.routeName);
            //   },
            // ),
          ],
        ),
        SizedBox(height: 80.0),
        SizedBox(
          height: 600.0,
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

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoryScreen(story),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 500.0,
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                ExtendedImage.network(
                                  IMG_PREFIX_HD + poster,
                                  fit: BoxFit.cover,
                                  cache: true,
                                  height: 250.0,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                Positioned(
                                  top: 12.0,
                                  right: 12.0,
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    child: SvgPicture.asset(
                                      svg,
                                      semanticsLabel: label,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 60.0,
                                    width: double.infinity,
                                    color: Colors.black12,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          story.movie.title,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          story.createDate,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
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
