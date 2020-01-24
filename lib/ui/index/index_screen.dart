import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view/index_mine.dart';
import './view/index_home.dart';
import '../../provider/theme_provider.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView(
        children: _contents,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        currentIndex: _currentTabIndex,
        selectedFontSize: 16.0,
        selectedIconTheme: IconThemeData(size: 26.0),
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
    );
  }
}
