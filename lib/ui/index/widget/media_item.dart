import 'package:flutter/material.dart';

class MediaItem extends StatefulWidget {
  final media;

  const MediaItem({this.media});

  @override
  _MediaItemState createState() => _MediaItemState();
}

class _MediaItemState extends State<MediaItem> {
  @override
  Widget build(BuildContext context) {
    final media = widget.media;

    return Card(
      child: Text(media.title),
    );
//    final img = widget.movie.posterPath ?? widget.movie.backdropPath;
//
//    return GestureDetector(
//      onTap: () => Navigator.pushNamed(
//        context,
//        MediaDetail.routeName,
//        arguments: widget.movie,
//      ),
//      child: Container(
//        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
//        decoration: BoxDecoration(
//          boxShadow: [
////            BoxShadow(
////              color: Colors.black.withOpacity(.1),
////              offset: Offset(0, 0),
////              blurRadius: 2,
////            ),
//          ],
//        ),
//        child: Hero(
//          tag: widget.movie.id,
//          child: ClipRRect(
//            borderRadius: BorderRadius.all(Radius.circular(10.0)),
//            child: FadeInImage(
//              fit: BoxFit.cover,
//              fadeInCurve: Curves.ease,
//              image: NetworkImage(IMG_PREFIX + img),
//              placeholder: AssetImage('assets/images/flutter.png'),
//            ),
//          ),
//        ),
//      ),
//    );
  }
}

//Image.network(
//IMG_PREFIX + img,
//loadingBuilder: (
//_,
//child,
//ImageChunkEvent progress,
//) {
//if (progress != null &&
//progress.cumulativeBytesLoaded >=
//progress.expectedTotalBytes) {
//setState(() {
//_enable = false;
//});
//}
//
//return Shimmer.fromColors(
//baseColor: Colors.grey[300],
//highlightColor: Colors.grey[100],
//enabled: _enable,
//child: child,
//);
//},
//),
