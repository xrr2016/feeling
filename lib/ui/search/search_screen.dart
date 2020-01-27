// import 'package:flappy_search_bar/flappy_search_bar.dart';
// import 'package:flappy_search_bar/search_bar_style.dart';
// import 'package:flutter/material.dart';

// class Post {
//   final String title;
//   final String description;

//   Post(this.title, this.description);
// }

// class SearchScreen extends StatefulWidget {
//   static String routeName = '/search';

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   Future<List<Post>> search(String search) async {
//     await Future.delayed(Duration(seconds: 2));
//     return List.generate(search.length, (int index) {
//       return Post(
//         "Title : $search $index",
//         "Description :$search $index",
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           height: 300,
//           child: SearchBar(
//             searchBarStyle: SearchBarStyle(
//               padding: EdgeInsets.symmetric(horizontal: 12.0),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             loader: Center(child: Text("loading...")),
//             emptyWidget: Center(child: Text("No result...")),
//             cancellationWidget: Icon(Icons.clear),
//             onSearch: search,
//             onItemFound: (Post post, int index) {
//               return ListTile(
//                 title: Text(post.title),
//                 subtitle: Text(post.description),
//               );
//             },
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SearchBar(
//             searchBarStyle: SearchBarStyle(
//               padding: EdgeInsets.symmetric(horizontal: 12.0),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             loader: Center(child: Text("loading...")),
//             emptyWidget: Center(child: Text("No result...")),
//             cancellationWidget: Icon(Icons.clear),
//             onSearch: search,
//             onItemFound: (Post post, int index) {
//               return ListTile(
//                 title: Text(post.title),
//                 subtitle: Text(post.description),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
