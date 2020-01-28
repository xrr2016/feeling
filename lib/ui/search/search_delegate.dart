import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../model/movie.dart';
import '../../const/api_const.dart';
import '../../styles.dart';
import '../movie/movie_screen.dart';
import '../../widget/loading.dart';
import '../../data/network/api_client.dart';

class AppSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search movies';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.black87),
      primaryColorBrightness: Brightness.light,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        this.close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                _currentPage = 1;
                // _totalPage = 1;
                _totalResults = 0;
                _results = [];
                // _isSearching = false;
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                showResults(context);
              },
            ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  // bool _isSearching = false;
  int _currentPage = 1;
  // int _totalPage = 1;
  int _totalResults = 0;
  List<Movie> _results = [];

  Future _searchMovies() async {
    // _isSearching = true;

    try {
      Response response = await apiClient.get(
        '/3/search/movie',
        queryParameters: {
          "query": this.query,
          "page": _currentPage,
          "include_adult": false,
        },
      );

      final data = response.data;
      final results = data["results"] as List;

      // _totalPage = data["total_pages"];
      _totalResults = data["total_results"];
      results.forEach((r) => _results.add(Movie.fromJson(r)));

      return true;
    } on DioError catch (err) {
      throw err;
    } finally {
      // _isSearching = false;
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Input you want to search.'));
    }

    if (query.length < 3) {
      return Center(
        child: Text(
          "Search term must be longer than two letters.",
        ),
      );
    }

    return FutureBuilder(
      future: _searchMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_totalResults > 0) {
            return buildResultList(_results);
          } else {
            return Center(child: Text('Not found..'));
          }
        }

        return Loading();
      },
    );
  }

  ListView buildResultList(List<Movie> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        Movie movie = results[index];
        final poster = movie.posterPath ?? movie.backdropPath;
        final tag = "search-$poster";

        return ListTile(
          isThreeLine: true,
          title: Text(
            movie?.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(movie.releaseDate ?? ''),
          trailing: Text(
            movie.voteAverage.toString() ?? '',
            style: Styles.info.copyWith(color: Colors.amber),
          ),
          leading: SizedBox(
            width: 120.0,
            child: poster != null
                ? Hero(
                    tag: tag,
                    child: ExtendedImage.network(
                      IMG_PREFIX + poster,
                      fit: BoxFit.cover,
                      cache: true,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                  )
                : SizedBox(height: 80.0),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieScreen(movie, tag),
              ),
            );
          },
        );
      },
    );
  }
}
