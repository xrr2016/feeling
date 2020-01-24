import 'package:flutter/material.dart';

import '../../../model/tv.dart';

class TvItem extends StatelessWidget {
  final Tv tv;

  const TvItem(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(tv.name),
    );
  }
}
