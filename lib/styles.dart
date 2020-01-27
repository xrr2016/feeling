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
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTitle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle normal = TextStyle(
    fontSize: 20.0,
  );

  static TextStyle info = TextStyle(
    fontSize: 18.0,
    color: Colors.white70,
  );
}
