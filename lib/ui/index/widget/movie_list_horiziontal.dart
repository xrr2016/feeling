import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../model/movie.dart';
import '../../../widget/loading.dart';

class MovieListHorizontal extends StatefulWidget {
  final List<Movie> movies;
  final String label;

  const MovieListHorizontal(this.movies, this.label);

  @override
  _MovieListHorizontalState createState() => _MovieListHorizontalState();
}

class _MovieListHorizontalState extends State<MovieListHorizontal> {
  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final _movies = widget.movies;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: Styles.subTitle),
          SizedBox(height: 24.0),
          SizedBox(
            height: 350.0,
            child: _movies.isNotEmpty
                ? Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 12.0),
                      itemExtent: 192.0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container();
                      },
                      itemCount: _movies.length,
                    ),
                  )
                : Loading(),
          ),
        ],
      ),
    );
  }
}
