import 'package:flutter/material.dart';

LinearGradient marsParty = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xff4776E6),
    Color(0xff8E54E9),
  ],
);

LinearGradient sharpBlues = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xff00c6fb),
    Color(0xff005bea),
  ],
);

LinearGradient spikyNaga = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  stops: [0.0, .12, .25, .37, .50, .62, .75, .87, 1.0],
  colors: [
    Color(0xff505285),
    Color(0xff585e92),
    Color(0xff65689f),
    Color(0xff7474b0),
    Color(0xff7e7ebb),
    Color(0xff8389c7),
    Color(0xff9795d4),
    Color(0xffa2a1dc),
    Color(0xffb5aee4)
  ],
);

LinearGradient backgroundReverse = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xff4776E6),
    Color(0xff8E54E9),
  ],
);

class BackgroundProvider extends ChangeNotifier {
  static List _values = [marsParty, sharpBlues, spikyNaga];

  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;

  LinearGradient _value = _values[0];

  get values => _values;

  get value => _value;

  void changeBackground(int index) async {
    if (index >= _values.length || index < 0) {
      return;
    }
    _selectedIndex = index;
    _value = _values[index];
    notifyListeners();
  }
}
