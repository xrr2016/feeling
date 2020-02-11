import 'package:Feeling/utils/screen_size.dart';
import 'package:flutter/material.dart';

class IndexDiscover extends StatelessWidget {
  const IndexDiscover({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      child: Text('discover'),
    );
  }
}
