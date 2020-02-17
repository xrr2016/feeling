import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static List<Color> _colors = [
    Colors.cyan,
    Colors.amber,
    Colors.indigo,
    Colors.purple,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.brown,
  ];

  // static ThemePreferences _themePreferences = ThemePreferences();

  int _selectedIndex = 0;

  Color _color = _colors[0];

  get color => _color;

  get colors => _colors;

  get selectedIndex => _selectedIndex;

  get brightness =>
      _color.computeLuminance() < 0.5 ? Brightness.dark : Brightness.light;

  get backgroundColor => Color(0xfff3f3f3);

  void changeTheme(int index) async {
    _selectedIndex = index;
    _color = _colors[_selectedIndex];
    // await _themePreferences.savePreferredThemeIndex(index);
    notifyListeners();
  }

  // initThemeColor() async {
  //   int index = await _themePreferences.getPreferredThemeIndex();

  //   if (index != null) {
  //     _selectedIndex = index;
  //     _color = _colors[_selectedIndex];
  //   } else {
  //     _selectedIndex = 0;
  //     _color = _colors[_selectedIndex];
  //     _themePreferences.savePreferredThemeIndex(_selectedIndex);
  //   }
  // }
}
