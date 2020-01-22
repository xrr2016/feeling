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

  List<ListTile> _buildListTiles(List<Color> colors) {
    List<ListTile> _listTiles = [];

    for (int i = 0; i < colors.length; i++) {
      _listTiles.add(_buildListTile(colors[i], i));
    }

    return _listTiles;
  }

  ListTile _buildListTile(Color color, int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(12.0),
      leading: Container(width: 36, height: 36, color: color),
      trailing: _currentIndex == index ? Icon(Icons.check) : null,
      onTap: () {
        setState(() {
          _currentIndex = index;
          Provider.of<ThemeProvider>(context, listen: false).changeTheme(index);
        });
      },
    );
  }

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
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  ListTile(title: Text('Theme setting')),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  Consumer<ThemeProvider>(
                    builder: (_, theme, child) {
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: theme.colors.length,
                          itemBuilder: (_, index) {
                            final colors = theme.colors;
                            return ListTile(
                              leading: Container(
                                width: 36,
                                height: 36,
                                color: colors[index],
                              ),
                              trailing: _currentIndex == index
                                  ? Icon(Icons.check)
                                  : null,
                              onTap: () {
                                setState(() {
                                  _currentIndex = index;
                                  theme.changeTheme(index);
                                });
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
