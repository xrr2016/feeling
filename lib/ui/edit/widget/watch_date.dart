import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../../const/api_const.dart';

class WatchDate extends StatefulWidget {
  final Movie movie;

  const WatchDate(this.movie);

  @override
  _WatchDateState createState() => _WatchDateState();
}

class _WatchDateState extends State<WatchDate> {
  String _watchDate = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;
    String poster = movie.posterPath ?? movie.backdropPath;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40.0),
          ExtendedImage.network(
            IMG_PREFIX + poster,
            cache: true,
            height: 300.0,
            fit: BoxFit.cover,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          SizedBox(height: 100.0),
          Text('Watch date', style: Styles.subTitle),
          SizedBox(height: 24.0),
          Text(_watchDate.toString(), style: Styles.title),
          SizedBox(height: 24.0),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Choose', style: Styles.normal),
              onPressed: () async {
                DateTime selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.year,
                );

                setState(() {
                  _watchDate = selectedDate.year.toString();
                });
              },
            ),
          ),
          Spacer(),
          FlatButton(
            child: Text('Skip', style: Styles.info),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
