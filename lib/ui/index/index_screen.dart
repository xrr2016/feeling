import 'package:flin/const/app_info.dart';
import 'package:flin/const/movie_types.dart';
import 'package:flin/styles.dart';
import 'package:flutter/material.dart';

import './view/index_mine.dart';
import './view/index_home.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentTabIndex = 0;
  List<Widget> _contents = [IndexHome(), IndexMine()];
  final _pageController = PageController();

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
//          leading: IconButton(
//            icon: Icon(Icons.filter_list),
//            onPressed: () async {
//              final result = await showMenu(
//                context: context,
//                position: RelativeRect.fromLTRB(50.0, 64.0, 100.0, 1.0),
//                items: [
//                  PopupMenuItem(
//                    value: movieTypes[0],
//                    child: Text(
//                      'Popular',
//                      style: _selectionIndex == 0
//                          ? TextStyle(fontWeight: FontWeight.bold)
//                          : TextStyle(fontWeight: FontWeight.normal),
//                    ),
//                  ),
//                  PopupMenuItem(
//                    value: movieTypes[1],
//                    child: Text(
//                      'Upcoming',
//                      style: _selectionIndex == 1
//                          ? TextStyle(fontWeight: FontWeight.bold)
//                          : TextStyle(fontWeight: FontWeight.normal),
//                    ),
//                  ),
//                  PopupMenuItem(
//                    value: movieTypes[2],
//                    child: Text(
//                      'Top',
//                      style: _selectionIndex == 2
//                          ? TextStyle(fontWeight: FontWeight.bold)
//                          : TextStyle(fontWeight: FontWeight.normal),
//                    ),
//                  ),
//                  PopupMenuItem(
//                    value: movieTypes[3],
//                    child: Text(
//                      'Now',
//                      style: _selectionIndex == 3
//                          ? TextStyle(fontWeight: FontWeight.bold)
//                          : TextStyle(fontWeight: FontWeight.normal),
//                    ),
//                  ),
//                ],
//              );
//
//              setState(() {
//                _movies = [];
//                _totalMoviePage = 1;
//                _currentMoviePage = 1;
//                _selectionIndex = movieTypes.indexOf(result);
//                _getMovies(type: result);
//              });
//            },
//          ),
          title: Text(
            AppInfo.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
          unselectedItemColor: Colors.white60,
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
              title: Text('mine'),
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
