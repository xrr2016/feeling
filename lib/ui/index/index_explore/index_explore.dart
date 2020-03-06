import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'explore_movie_list.dart';

class IndexExplore extends StatefulWidget {
  @override
  _IndexExploreState createState() => _IndexExploreState();
}

class _IndexExploreState extends State<IndexExplore>
    with SingleTickerProviderStateMixin {
  List<String> _titles = ['Popular', 'Playing', 'Upcoming', 'Top'];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _titles.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        title: TabBar(
          isScrollable: true,
          controller: _tabController,
          dragStartBehavior: DragStartBehavior.start,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle:
              TextStyle(fontSize: Theme.of(context).textTheme.title.fontSize),
          tabs: _titles.map((String name) => Tab(text: name)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ExploreMovieList(movieType: 'popular'),
          ExploreMovieList(movieType: 'now_playing'),
          ExploreMovieList(movieType: 'upcoming'),
          ExploreMovieList(movieType: 'top_rated'),
        ],
      ),
    );
  }
}
