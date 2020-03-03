import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:Feeling/model/movie.dart';

class Tmdb {
  static String baseUrl = 'https://api.themoviedb.org/';
  static String imgPrefix = "https://image.tmdb.org/t/p";
  static String imgNormal = '$imgPrefix/w500';
  static String imgHigh = '$imgPrefix/w780';

  static Dio client = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    queryParameters: {
      "api_key": DotEnv().env['TMDB_AUTH_V3'],
    },
  ));

  static void init() {
    client.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        compact: true,
      ),
    );

    client.interceptors.add(
      DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor,
    );
  }

  static Future getMovies({
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
      final int total = data["total_pages"];
      results.forEach((r) => movies.add(Movie.fromJson(r)));

      return {
        "movies": movies,
        "total": total,
      };
    } on DioError catch (err) {
      return err.message;
    }
  }

  static Future getTrendingMovies({
    String time = 'day',
    int page = 1,
  }) async {
    try {
      Response response = await client.get(
        '/3/trending/movie/$time',
        queryParameters: {"page": page},
      );

      List<Movie> movies = [];
      final data = response.data;
      final results = data["results"] as List;
      final int total = data["total_pages"];
      results.forEach((r) => movies.add(Movie.fromJson(r)));

      return {
        "movies": movies,
        "total": total,
      };
    } on DioError catch (err) {
      if (err.type == DioErrorType.CONNECT_TIMEOUT) {
        return 'Timeout, please try again.';
      }

      return err.message;
    }
  }
}
