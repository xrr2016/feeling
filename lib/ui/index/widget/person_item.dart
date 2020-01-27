import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../model/person.dart';
import '../../../const/api_const.dart';
import '../../../styles.dart';
import '../../../ui/person/person_screen.dart';

class PersonItem extends StatelessWidget {
  final Person person;

  const PersonItem(this.person);

  @override
  Widget build(BuildContext context) {
    bool hasProfileImg = person.profilePath != null;

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PersonScreen(person)),
          );
        },
        child: hasProfileImg
            ? SizedBox(
                height: 320.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Hero(
                        tag: person.id,
                        child: ExtendedImage.network(
                          IMG_PREFIX + person.profilePath,
                          cache: true,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12.0,
                      left: 12.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            person.name,
                            style: Styles.title.copyWith(color: Colors.white),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.whatshot,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                person.popularity.roundToDouble().toString(),
                                style:
                                    Styles.normal.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
