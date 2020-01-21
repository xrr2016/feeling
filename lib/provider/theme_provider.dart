import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static List<Color> _colors = [
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.red,
  ];

  int _selectedIndex = 0;

  Color _color = _colors[0];

  get color => _color;

  get colors => _colors;

  get selectedIndex => _selectedIndex;

  get fontColor =>
      _color.computeLuminance() < 0.5 ? Colors.white : Colors.black;

  get backgroundColor => Color(0xfff3f3f3);

  void changeTheme(int index) async {
    _selectedIndex = index;
    _color = _colors[_selectedIndex];
    notifyListeners();
  }

//  _initThemeColor() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    bool hasColor = prefs.containsKey('theme_color');
//
//    if (hasColor) {
//      int colorInt = prefs.getInt('theme_color');
//      print(colorInt);
//      _color = Color(colorInt);
//    } else {
//      prefs.setInt('theme_color', _color.value);
//    }
//  }
}
