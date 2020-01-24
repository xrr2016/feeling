import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../styles.dart';
import '../../model/story.dart';
import '../../const/api_const.dart';
import '../../widget/place_holder.dart';

class EditScreen extends StatefulWidget {
  final media;

  const EditScreen(this.media);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  Story _story = Story();
  int _currentPage = 0;
  FocusNode _focusNode = FocusNode();
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.media;
    final img = media.posterPath ?? media.backdropPath;
    final feels = Feels.values;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 240,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.ease,
                          image: NetworkImage(IMG_PREFIX + img),
                          placeholder: placeholder,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            media.title,
                            style: Styles.subTitle,
                          ),
                          Text(
                            media.releaseDate,
                            style: Styles.normal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Feel'),
                      SizedBox(
                        height: 40.0,
                        child: ListView.builder(
                          itemCount: feels.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                print('awesome');
                                _story.feel = 'awesome';
                              },
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                margin: EdgeInsets.only(left: 12.0),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                child: Text('Awesome'),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Rate'),
                      SmoothStarRating(
                        onRatingChanged: (val) {
                          setState(() {
                            _story.rate = val;
                          });
                        },
                        allowHalfRating: true,
                        size: 30.0,
                        starCount: 10,
                        rating: _story.rate,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        color: Colors.amber,
                        borderColor: Colors.amber,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Review'),
                      TextField(
                        focusNode: _focusNode,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        minLines: 3,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String val) {
                          _story.review = val;
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _currentPage > 0
                    ? IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          if (_currentPage > 0) {
                            _currentPage--;
                          }

                          _pageController.jumpToPage(_currentPage);
                        },
                      )
                    : Container(),
                _currentPage < 2
                    ? IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () {
                          if (_currentPage < 2) {
                            _currentPage++;
                          }
                          _pageController.jumpToPage(_currentPage);
                        },
                      )
                    : RaisedButton(
                        onPressed: () {
                          print(_story.rate);
                          print(_story.feel);
                          print(_story.review);
                        },
                        child: Text('Save'),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
