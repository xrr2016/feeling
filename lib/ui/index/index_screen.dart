import 'package:Feeling/ui/index/view/index_trending.dart';
import 'package:Feeling/ui/search/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/screen_size.dart';
import './provider/trending_provider.dart';
import '../../widget/loyout.dart';
import './view/index_mine.dart';
import './view/index_home.dart';

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
  List<Widget> _contents = [IndexTrending(), IndexHome(), IndexMine()];

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
    return ChangeNotifierProvider(
      create: (_) => TrendingProvider(),
      child: Layout(
        child: Scaffold(
          // appBar: AppBar(
          //   elevation: 0.0,
          //   backgroundColor: Colors.transparent,
          //   title: SizedBox(
          //     height: 40.0,
          //     child: ListView.builder(
          //       padding: EdgeInsets.only(left: 12.0),
          //       shrinkWrap: true,
          //       scrollDirection: Axis.horizontal,
          //       itemCount: _titles.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               _currentIndex = index;
          //             });
          //           },
          //           child: Container(
          //             margin: EdgeInsets.only(right: 12.0),
          //             child: Text(
          //               _titles[index],
          //               style: _currentIndex == index
          //                   ? Styles.subTitle
          //                   : Styles.subTitle
          //                       .copyWith(fontWeight: FontWeight.w100),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          //   actions: <Widget>[
          //     IconButton(
          //       tooltip: 'Search',
          //       icon: const Icon(Icons.search),
          //       onPressed: () {
          //         showSearch(context: context, delegate: AppSearchDelegate());
          //       },
          //     ),
          //     IconButton(
          //       tooltip: 'Setting',
          //       icon: const Icon(Icons.settings),
          //       onPressed: () {
          //         Navigator.of(context).pushNamed(SettingScreen.routeName);
          //       },
          //     ),
          //   ],
          // ),
          body: SizedBox(
            height: screenHeightExcludingToolbar(context),
            child: PageView(
              children: _contents,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentTabIndex,
            backgroundColor: Colors.transparent,
            onTap: (int index) {
              setState(() {
                _currentTabIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                title: Container(),
                icon: Icon(Icons.trending_up),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: Icon(Icons.explore),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                title: Container(),
                icon: IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.search),
                  onPressed: () => showSearch(
                    context: context,
                    delegate: AppSearchDelegate(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
