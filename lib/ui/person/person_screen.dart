import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';
import '../../model/person.dart';
import '../../const/api_const.dart';
import '../../widget/loading.dart';
import '../../widget/place_holder.dart';
import '../../model/person_detail.dart';
import '../../data/network/api_client.dart';

class PersonScreen extends StatefulWidget {
  final Person person;

  const PersonScreen(this.person);

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  Future _getPersonDetail(int id, {String language = 'en-US'}) async {
    try {
      Response response = await ApiClient.get(
        '/3/person/$id',
        queryParameters: {
          "language": language,
        },
      );

      final data = response.data;
      final PersonDetail personDetail = PersonDetail.fromJson(data);

      return personDetail;
    } on DioError catch (err) {
      throw err;
    } finally {}
  }

  @override
  void initState() {
    super.initState();
    _getPersonDetail(widget.person.id);
  }

  @override
  Widget build(BuildContext context) {
    Person person = widget.person;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
            pinned: true,
            expandedHeight: 240.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: person.id,
                child: Image.network(
                  IMG_PREFIX + person.profilePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 36.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: <Widget>[
                        Text(person.name, style: Styles.title),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: _getPersonDetail(person.id),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        PersonDetail detail = snapshot.data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.cake, size: 20.0),
                                  SizedBox(width: 4.0),
                                  Text(detail.birthday, style: Styles.normal),
                                  SizedBox(width: 12.0),
                                  Icon(Icons.whatshot, size: 20.0),
                                  SizedBox(width: 4.0),
                                  Text(
                                    person.popularity
                                        .roundToDouble()
                                        .toString(),
                                    style: Styles.normal,
                                  ),
                                ],
                              ),
                            ),
                            detail.homepage != null
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text('Home page',
                                              style: Styles.subTitle),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/web',
                                              arguments: detail.homepage,
                                            );
                                          },
                                          child: Text(
                                            detail.homepage,
                                            style: Styles.normal.copyWith(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            detail.biography.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text('Biography',
                                              style: Styles.subTitle),
                                        ),
                                        Text(detail.biography,
                                            style: Styles.normal),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        );
                      }
                      return Loading();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text('Known for', style: Styles.subTitle),
                        ),
                        Container(
                          height: 480.0,
                          margin: EdgeInsets.only(bottom: 12.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: person.knownFor.length,
                            itemExtent: 320.0,
                            itemBuilder: (_, index) {
                              final KnownFor knownFor = person.knownFor[index];

                              return Container(
                                margin: EdgeInsets.only(right: 12.0),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  fadeInCurve: Curves.ease,
                                  image: NetworkImage(
                                      IMG_PREFIX + knownFor.posterPath),
                                  placeholder: placeholder,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            print('add to favorite');
          },
        ),
      ),
    );
  }
}
