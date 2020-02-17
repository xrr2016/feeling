import 'package:Feeling/ui/setting/setting_screen.dart';
import 'package:Feeling/widget/loyout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:extended_image/extended_image.dart';

import '../../utils/screen_size.dart';
import './provider/trending_provider.dart';
import '../../styles.dart';
import './view/index_mine.dart';
// import '../../const/app_info.dart';
import './view/index_home.dart';
import './view/index_trending.dart';
import '../search/search_delegate.dart';

class IndexScreen extends StatefulWidget {
  final int initPage;

  static String routeName = '/index-screen';

  const IndexScreen({this.initPage = 0});

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentTabIndex;
  PageController _pageController;
  List<Widget> _contents = [
    IndexHome(),
    // IndexDiscover(),
    // IndexTrending(),
    IndexMine()
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  List _titles = ['Popular', 'Playing', 'Upcoming', 'Trending', 'Top'];
  int _currentIndex = 0;

  @override
  void initState() {
    _currentTabIndex = widget.initPage;
    _pageController = PageController(initialPage: widget.initPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrendingProvider(),
      child: Layout(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: SizedBox(
              height: 40.0,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 12.0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _titles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12.0),
                      child: Text(
                        _titles[index],
                        style: _currentIndex == index
                            ? Styles.subTitle
                            : Styles.subTitle
                                .copyWith(fontWeight: FontWeight.w100),
                      ),
                    ),
                  );
                },
              ),
            ),
            actions: <Widget>[
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: AppSearchDelegate());
                },
              ),
              IconButton(
                tooltip: 'Setting',
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingScreen.routeName);
                },
              ),
            ],
          ),
          // extendBodyBehindAppBar: true,
          body: SizedBox(
            height: screenHeightExcludingToolbar(context),
            child: PageView(
              children: _contents,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
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
                icon: Icon(Icons.explore),
              ),
              BottomNavigationBarItem(
                title: Text('mine'),
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
