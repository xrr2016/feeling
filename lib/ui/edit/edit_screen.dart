import 'package:flin/ui/edit/widget/watch_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../model/movie.dart';
import '../../styles.dart';

class EditScreen extends StatefulWidget {
  final Movie movie;

  const EditScreen(this.movie);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    final Movie _movie = widget.movie;

    final List _contents = [WatchDate(_movie)];

    return DecoratedBox(
      decoration: BoxDecoration(gradient: Styles.background),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Swiper(
            loop: false,
            itemCount: 1,
            // control: SwiperControl(
            //   size: 32.0,
            //   color: Colors.white,
            // ),
            pagination: SwiperPagination(
              margin: EdgeInsets.all(12.0),
              alignment: Alignment.topRight,
            ),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return _contents[index];
            },
          ),
        ),
      ),
    );
  }
}

//Column(
//children: <Widget>[
//GestureDetector(
//onTap: () {
//_focusNode.unfocus();
//},
//child: Container(
//margin: EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
//child: Row(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//SizedBox(
//width: 200,
//height: 240,
//child: ClipRRect(
//borderRadius: BorderRadius.all(Radius.circular(10.0)),
//child: FadeInImage(
//fit: BoxFit.cover,
//fadeInCurve: Curves.ease,
//image: NetworkImage(IMG_PREFIX + img),
//placeholder: placeholder,
//),
//),
//),
//SizedBox(
//width: 12.0,
//),
//Expanded(
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Text(
//media.title,
//style: Styles.subTitle,
//),
//Text(
//media.releaseDate,
//style: Styles.normal,
//),
//],
//),
//),
//],
//),
//),
//),
//SizedBox(
//height: 300.0,
//child: PageView(
//controller: _pageController,
//onPageChanged: (index) {
//setState(() {
//_currentPage = index;
//});
//},
//children: <Widget>[
//Column(
//children: <Widget>[
//Text('Feel'),
//SizedBox(
//height: 40.0,
//child: ListView.builder(
//itemCount: feels.length,
//scrollDirection: Axis.horizontal,
//itemBuilder: (_, index) {
//return GestureDetector(
//onTap: () {
//print('awesome');
//_story.feel = 'awesome';
//},
//child: Container(
//width: 100.0,
//height: 100.0,
//margin: EdgeInsets.only(left: 12.0),
//decoration: BoxDecoration(
//color: Colors.orange,
//),
//child: Text('Awesome'),
//),
//);
//},
//),
//)
//],
//),
//Column(
//children: <Widget>[
//Text('Rate'),
//SmoothStarRating(
//onRatingChanged: (val) {
//setState(() {
//_story.rate = val;
//});
//},
//allowHalfRating: true,
//size: 30.0,
//starCount: 10,
//rating: _story.rate,
//filledIconData: Icons.star,
//halfFilledIconData: Icons.star_half,
//color: Colors.amber,
//borderColor: Colors.amber,
//)
//],
//),
//Column(
//children: <Widget>[
//Text('Review'),
//TextField(
//focusNode: _focusNode,
//textCapitalization: TextCapitalization.sentences,
//textInputAction: TextInputAction.done,
//minLines: 3,
//maxLines: 6,
//decoration: InputDecoration(
//border: OutlineInputBorder(),
//),
//onChanged: (String val) {
//_story.review = val;
//},
//)
//],
//),
//],
//),
//),
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//_currentPage > 0
//? IconButton(
//icon: Icon(Icons.keyboard_arrow_left),
//onPressed: () {
//if (_currentPage > 0) {
//_currentPage--;
//}
//
//_pageController.jumpToPage(_currentPage);
//},
//)
//: Container(),
//_currentPage < 2
//? IconButton(
//icon: Icon(Icons.keyboard_arrow_right),
//onPressed: () {
//if (_currentPage < 2) {
//_currentPage++;
//}
//_pageController.jumpToPage(_currentPage);
//},
//)
//: RaisedButton(
//onPressed: () {
//print(_story.rate);
//print(_story.feel);
//print(_story.review);
//},
//child: Text('Save'),
//),
//],
//),
//],
//),
