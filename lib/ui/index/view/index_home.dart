import 'package:flutter/material.dart';

import '../widget/movie_list_trending.dart';
import '../widget/movie_list_horiziontal.dart';

class IndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white70,
        ),
        MovieListHorizontal(),
        MovieListTrending(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
