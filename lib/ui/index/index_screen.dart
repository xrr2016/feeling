import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view/index_mine.dart';
import './view/index_trending.dart';
import '../../provider/theme_provider.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex = 0;
  List<Widget> _contents = [IndexTrending(), IndexMine()];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, child) {
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                color: Colors.grey,
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            currentIndex: _currentTabIndex,
            selectedFontSize: 16.0,
            selectedIconTheme: IconThemeData(size: 26.0),
            items: [
              BottomNavigationBarItem(
                title: Text('trending'),
                icon: Icon(Icons.whatshot),
              ),
              BottomNavigationBarItem(
                title: Text('mine'),
                icon: Icon(Icons.person),
              ),
            ],
          ),
        );
      },
      child: _contents[_currentTabIndex],
    );
  }
}

//      drawer: Drawer(
//        child: Consumer<ThemeProvider>(
//          builder: (_, theme, child) {
//            return DecoratedBox(
//              decoration: BoxDecoration(
//                color: theme.backgroundColor,
//              ),
//              child: child,
//            );
//          },
//          child: Column(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                ),
//                child: ListTile(
//                  title: Text('Settings'),
//                  trailing: Icon(Icons.arrow_forward_ios),
//                  onTap: () => Navigator.pushNamed(
//                    context,
//                    SettingScreen.routeName,
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
