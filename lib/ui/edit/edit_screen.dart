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

  static String _formatDate(DateTime date) {
    return formatDate(date, [yyyy, '.', mm, '.', dd]);
  }

  FlatButton _moveTo(int index) {
    return FlatButton(
      child: Text('next', style: Styles.info),
      onPressed: () {
        _swiperController.move(index);
      },
    );
  }

  Widget _buildWatchDate(String poster) {
    return Column(
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
        Text(StoryQuestion.watchDate, style: Styles.normal),
        SizedBox(height: 140.0),
        Text(_watchDate.toString(), style: Styles.title),
        SizedBox(height: 24.0),
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
              _watchDate = _formatDate(selectedDate);
              _swiperController.next();
            });
          },
        ),
        Spacer(),
        _moveTo(1),
      ],
    );
  }

  Widget _buildFeeling(String poster) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 24.0,
          left: 24.0,
          child: ExtendedImage.network(
            IMG_PREFIX + poster,
            cache: true,
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          top: 148.0,
          left: 24.0,
          child: Text(StoryQuestion.feeling, style: Styles.normal),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            height: 124.0,
            child: ListView.builder(
              itemExtent: 124.0,
              scrollDirection: Axis.horizontal,
              itemCount: FeelEmoji.list.length,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
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
        Positioned(
          top: 500.0,
          left: screenWidth(context) / 2 - 60,
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            onPressed: () {
              _swiperController.next();
            },
            child: Text(
              'Confirm',
              style:
                  Styles.normal.copyWith(decoration: TextDecoration.underline),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _moveTo(2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Movie _movie = widget.movie;
    String poster = _movie.posterPath ?? _movie.backdropPath;
    List pages = [
      _buildWatchDate(poster),
      _buildFeeling(poster),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(gradient: Styles.background),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Swiper(
            loop: false,
            itemCount: pages.length,
            controller: _swiperController,
            // control: SwiperControl(),
            // pagination: SwiperPagination(
            //   margin: EdgeInsets.all(12.0),
            //   alignment: Alignment.topRight,
            // ),
            pagination: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
                int activeIndex = config.activeIndex;
                return Positioned(
                  top: 24.0,
                  right: 24.0,
                  child: Column(
                    children: List.generate(config.itemCount, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeIndex == index
                              ? Colors.white
                              : Colors.white54,
                        ),
                        margin: EdgeInsets.only(bottom: 6.0),
                        width: 8.0,
                        height: 8.0,
                      );
                    }),
                  ),
                );
              },
            ),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return pages[index];
            },
          ),
        ),
      ),
    );
  }
}
