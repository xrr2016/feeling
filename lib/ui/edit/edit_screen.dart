import 'package:feeling/const/feel_emoji.dart';
import 'package:feeling/utils/screen_size.dart';
// import 'package:feeling/model/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:date_format/date_format.dart';

import '../../const/story_question.dart';
import '../../const/api_const.dart';
import '../../model/movie.dart';
import '../../styles.dart';

class EditScreen extends StatefulWidget {
  final Movie movie;

  const EditScreen(this.movie);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  SwiperController _swiperController = SwiperController();
  String _watchDate = _formatDate(DateTime.now());
  int _feelIndex = 0;
  double _rate = 5.0;

  static String _formatDate(DateTime date) {
    return formatDate(date, [yyyy, '.', mm, '.', dd]);
  }

  Widget _buildWatchDate() {
    return Column(
      children: <Widget>[
        SizedBox(height: 48.0),
        Text(StoryQuestion.watchDate, style: Styles.normal),
        SizedBox(height: 100.0),
        Text(
          _watchDate.toString(),
          style: Styles.title.copyWith(fontSize: 36.0),
        ),
        SizedBox(height: 64.0),
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Choose',
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
                _swiperController.next();
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
        SizedBox(height: 48.0),
        Text(StoryQuestion.feeling, style: Styles.normal),
        SizedBox(height: 80.0),
        SizedBox(
          width: double.infinity,
          height: 124.0,
          child: Scrollbar(
            child: ListView.builder(
              itemExtent: 124.0,
              scrollDirection: Axis.horizontal,
              itemCount: FeelEmoji.list.length,
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              itemBuilder: (context, index) {
                final asset = FeelEmoji.list[index];
                final svg = asset['svg'];
                final label = asset['label'];

                return InkWell(
                  splashColor: Colors.indigo,
                  onTap: () {
                    setState(() {
                      _feelIndex = index;
                    });
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _feelIndex == index ? Colors.white10 : null,
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
                        Text(asset['label'], style: Styles.normal)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 42.0),
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          onPressed: () {
            _swiperController.next();
          },
          child: Text(
            'Confirm',
            style: Styles.normal.copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildRate() {
    return Column(
      children: <Widget>[
        SizedBox(height: 48.0),
        Text(StoryQuestion.feeling, style: Styles.normal),
        SizedBox(height: 60.0),
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
        SizedBox(height: 42.0),
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          onPressed: () {
            _swiperController.next();
          },
          child: Text(
            'Confirm',
            style: Styles.normal.copyWith(decoration: TextDecoration.underline),
          ),
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
                    size: 24.0,
                    color: Colors.white,
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
