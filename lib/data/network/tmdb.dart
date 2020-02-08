import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../model/movie.dart';

class Tmdb {
  static String baseUrl = 'https://api.themoviedb.org/';
  static String imgPrefix = "https://image.tmdb.org/t/p";
  static String imgNormal = '$imgPrefix/w500';
  static String imgHigh = '$imgPrefix/w780';

  static Dio client = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 3000,
    queryParameters: {
      "api_key": DotEnv().env['TMDB_AUTH_V3'],
    },
  ));

  static void init() {
    client.interceptors.add(PrettyDioLogger(
      error: true,
      request: false,
      responseBody: false,
      responseHeader: false,
      requestHeader: false,
      compact: true,
    ));
  }

  Future<List<Movie>> getMovies({
    String type = 'upcoming',
    Map<String, dynamic> query,
    Options options,
  }) async {
    try {
      Response response = await client.get(
        '/3/movie/$type',
        queryParameters: query,
        options: options,
      );

      List<Movie> movies = [];
      final data = response.data;
      final results = data["results"] as List;
      results.forEach((r) => movies.add(Movie.fromJson(r)));

      return movies;
    } on DioError catch (err) {
      throw err;
    }
  }
}
