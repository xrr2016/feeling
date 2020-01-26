import 'package:flutter/material.dart';

import '../../const/app_info.dart';
import './view/index_mine.dart';
import './view/index_home.dart';
import './view/index_trending.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentTabIndex = 0;
  final _pageController = PageController(initialPage: 0);
  List<Widget> _contents = [IndexHome(), IndexTrending(), IndexMine()];

  void _onPageChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff4776E6),
            Color(0xff8E54E9),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
//                Navigator.pushNamed(context, SearchScreen.routeName);
//                showSearch(context: null, delegate: null);
              },
            ),
          ],
        ),
//        extendBodyBehindAppBar: true,
        body: PageView(
          children: _contents,
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          backgroundColor: Colors.transparent,
          currentIndex: _currentTabIndex,
          onTap: (int index) {
            setState(() {
              _currentTabIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text('home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('trending'),
              icon: Icon(Icons.trending_up),
            ),
            BottomNavigationBarItem(
              title: Text('mine'),
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
