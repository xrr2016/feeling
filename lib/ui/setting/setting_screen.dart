import 'package:Feeling/store/background_provider.dart';
import 'package:Feeling/store/theme_provider.dart';
import 'package:Feeling/widget/loyout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SingingCharacter { lafayette, jefferson }

class SettingScreen extends StatefulWidget {
  static String routeName = '/setting-screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _currentIndex = 0;

  int _bgIndex = 0;

// ...

  SingingCharacter _character = SingingCharacter.lafayette;

  @override
  void initState() {
    super.initState();
    _currentIndex =
        Provider.of<ThemeProvider>(context, listen: false).selectedIndex;
    _bgIndex =
        Provider.of<BackgroundProvider>(context, listen: false).selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, BackgroundProvider>(
      builder: (context, theme, background, child) {
        return Layout(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Settinng'),
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Theme setting'),
                ),
                SizedBox(
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
                ),
                ListTile(
                  title: Text(
                    'Background setting',
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 12.0),
                    scrollDirection: Axis.horizontal,
                    itemExtent: 112.0,
                    itemCount: background.values.length,
                    semanticChildCount: background.values.length,
                    itemBuilder: (_, index) {
                      final colors = background.values;

                      return Stack(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _bgIndex = index;
                                background.changeBackground(index);
                              });
                            },
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                gradient: colors[index],
                              ),
                              margin: EdgeInsets.only(right: 12.0),
                            ),
                          ),
                          _bgIndex == index
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Language setting',
                  ),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Lafayette'),
                      leading: Radio(
                        value: SingingCharacter.lafayette,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Thomas Jefferson'),
                      leading: Radio(
                        value: SingingCharacter.jefferson,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                AboutListTile(),
              ],
            ),
          ),
        );
      },
    );
  }
}
