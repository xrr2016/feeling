import 'package:feeling/ui/index/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:date_format/date_format.dart';
import 'package:hive/hive.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../styles.dart';
import '../../model/story.dart';
import '../../model/movie.dart';
import '../../const/api_const.dart';
import '../../const/feel_emoji.dart';
import '../../data/box/story_box.dart';
import '../../const/story_question.dart';

class EditScreen extends StatefulWidget {
  final Movie movie;

  const EditScreen(this.movie);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  SwiperController _swiperController = SwiperController();
  double _rate;
  String _feel = 'haha';
  String _watchDate = _formatDate(DateTime.now());
  TextEditingController _reviewController = TextEditingController(text: '');
  Box<Story> storyBox = Hive.box<Story>(StoryBox.name);

  @override
  void initState() {
    _rate = widget.movie.voteAverage ?? 5.0;
    super.initState();
  }

  static String _formatDate(DateTime date) {
    return formatDate(date, [yyyy, '.', mm, '.', dd]);
  }

  Widget _buildWatchDate() {
    return Column(
      children: <Widget>[
        SizedBox(height: 120.0),
        Text(StoryQuestion.watchDate, style: Styles.normal),
        SizedBox(height: 48.0),
        Text(
          _watchDate.toString(),
          style: Styles.title.copyWith(fontSize: 36.0),
        ),
        SizedBox(height: 24.0),
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Change',
            style: Styles.normal.copyWith(decoration: TextDecoration.underline),
          ),
          onPressed: () async {
            DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDatePickerMode: DatePickerMode.year,
            );
            setState(() {
              if (selectedDate != null) {
                _watchDate = _formatDate(selectedDate);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildFeeling() {
    return Column(
      children: <Widget>[
        SizedBox(height: 120.0),
        Text(StoryQuestion.feeling, style: Styles.normal),
        SizedBox(height: 48.0),
        SizedBox(
          width: double.infinity,
          height: 124.0,
          child: ListView.builder(
            itemExtent: 100.0,
            scrollDirection: Axis.horizontal,
            itemCount: FeelEmoji.list.length,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final asset = FeelEmoji.list[index];
              final svg = asset['svg'];
              final label = asset['label'];

              return InkWell(
                splashColor: Colors.indigo,
                onTap: () {
                  setState(() {
                    _feel = label;
                  });
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _feel == label ? Colors.white10 : null,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        child: SvgPicture.asset(svg, semanticsLabel: label),
                      ),
                      SizedBox(height: 12.0),
                      Text(asset['label'], style: Styles.normal),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRate() {
    return Column(
      children: <Widget>[
        SizedBox(height: 120.0),
        Text(StoryQuestion.rate, style: Styles.normal),
        SizedBox(height: 48.0),
        Text(
          _rate.toStringAsFixed(1),
          style: Styles.title.copyWith(fontSize: 36.0),
        ),
        SizedBox(height: 24.0),
        Slider(
          min: 0.0,
          max: 10.0,
          value: _rate,
          activeColor: Colors.white,
          inactiveColor: Colors.white30,
          onChanged: (double value) {
            setState(() {
              _rate = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildReview() {
    return Column(
      children: <Widget>[
        SizedBox(height: 120.0),
        Text(StoryQuestion.review, style: Styles.normal),
        SizedBox(height: 48.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: TextField(
            maxLength: 240,
            autofocus: true,
            cursorColor: Colors.white,
            controller: _reviewController,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'your review here',
              hintStyle: TextStyle(color: Colors.white70),
              contentPadding: EdgeInsets.all(12.0),
              counterStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ),
        SizedBox(height: 48.0),
        MaterialButton(
          color: Colors.cyan,
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 16.0),
          onPressed: () {
            Story _story = Story(
              feel: _feel,
              rate: _rate,
              movie: widget.movie,
              watchDate: _watchDate,
              review: _reviewController.text,
              movieId: widget.movie.id.toString(),
              updateDate: _formatDate(DateTime.now()),
              createDate: _formatDate(DateTime.now()),
            );

            int foundStores = storyBox.values
                .where((story) => story.movieId == _story.movieId)
                .length;

            if (foundStores > 0) {
              BotToast.showSimpleNotification(
                title: "Story exist.",
                align: Alignment.center,
                onlyOne: true,
                crossPage: false,
                hideCloseButton: true,
                enableSlideOff: true,
                subTitle: 'View',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndexScreen(initPage: 2),
                      settings: RouteSettings(arguments: 1),
                    ),
                  );
                },
              );
            } else {
              storyBox.add(_story);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IndexScreen(initPage: 2),
                  settings: RouteSettings(arguments: 0),
                ),
              );
            }
          },
          child: Text('Save story', style: Styles.subTitle),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Movie _movie = widget.movie;
    String poster = _movie.posterPath ?? _movie.backdropPath;

    List pages = [
      _buildWatchDate(),
      _buildFeeling(),
      _buildRate(),
      _buildReview(),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(gradient: Styles.background),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(height: 24.0),
              ExtendedImage.network(
                IMG_PREFIX + poster,
                cache: true,
                height: 200.0,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              SizedBox(height: 24.0),
              Expanded(
                child: Swiper(
                  loop: false,
                  itemCount: pages.length,
                  controller: _swiperController,
                  scrollDirection: Axis.vertical,
                  control: SwiperControl(
                    size: 20.0,
                    color: Colors.white,
                    disableColor: Colors.white30,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return pages[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
