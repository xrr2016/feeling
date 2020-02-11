import 'package:flutter/material.dart';

class Styles {
  static LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff4776E6),
      Color(0xff8E54E9),
    ],
  );

  static LinearGradient background2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffe0c3fc),
      Color(0xff8ec5fc),
    ],
  );

  static LinearGradient background3 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff00c6fb),
      Color(0xff005bea),
    ],
  );

  static LinearGradient background4 = LinearGradient(
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

  static LinearGradient backgroundReverse = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xff4776E6),
      Color(0xff8E54E9),
    ],
  );

  static TextStyle title = TextStyle(
    fontSize: 28.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTitle = TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle normal = TextStyle(
    fontSize: 20.0,
    color: Colors.white,
  );

  static TextStyle info = TextStyle(
    fontSize: 18.0,
    color: Colors.white70,
  );
}
