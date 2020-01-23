import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = '/setting-screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex =
        Provider.of<ThemeProvider>(context, listen: false).selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settinng'),
          ),
          backgroundColor: theme.backgroundColor,
          body: child,
        );
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          ListTile(title: Text('Theme setting')),
          Consumer<ThemeProvider>(
            builder: (_, theme, child) {
              return SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  itemExtent: 64,
                  semanticChildCount: theme.colors.length,
                  scrollDirection: Axis.horizontal,
                  itemCount: theme.colors.length,
                  itemBuilder: (_, index) {
                    final colors = theme.colors;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          theme.changeTheme(index);
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 12.0, right: 12.0),
                            color: colors[index],
                          ),
                          _currentIndex == index
                              ? Align(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
