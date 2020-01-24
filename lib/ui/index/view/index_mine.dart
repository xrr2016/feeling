import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IndexMine extends StatefulWidget {
  @override
  _IndexMineState createState() => _IndexMineState();
}

class _IndexMineState extends State<IndexMine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 500.0,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                "https://game.gtimg.cn/images/lol/act/img/skin/big39006.jpg",
                fit: BoxFit.fill,
              );
            },
            itemCount: 3,
            itemWidth: 300.0,
            itemHeight: 400.0,
            containerWidth: double.infinity,
            containerHeight: 400.0,
            layout: SwiperLayout.STACK,
          ),
        ),
        Text('test')
      ],
    );
  }
}
