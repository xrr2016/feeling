import 'package:flutter/material.dart';

import '../../utils/screen_size.dart';
import '../../widget/loyout.dart';
import 'index_explore/index_explore.dart';
import 'index_story/index_story.dart';
import 'index_trending/index_trending.dart';

class IndexScreen extends StatefulWidget {
  final int initPage;
  static String routeName = '/index-screen';
  const IndexScreen({this.initPage = 0});

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex;
  PageController _pageController;
  List<Widget> _contents = [IndexTrending(), IndexExplore(), IndexStory()];

  @override
  void initState() {
    _currentTabIndex = widget.initPage;
    _pageController = PageController(
      keepPage: true,
      initialPage: widget.initPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        body: PageView(
          children: _contents,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentTabIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black38,
          backgroundColor: Colors.transparent,
          onTap: (int index) {
            setState(() {
              _currentTabIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text('trending'),
              icon: Icon(Icons.trending_up),
            ),
            BottomNavigationBarItem(
              title: Text('explore'),
              icon: Icon(Icons.explore),
            ),
            BottomNavigationBarItem(
              title: Text('story'),
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
