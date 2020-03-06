import 'dart:io';

import 'package:devicelocale/devicelocale.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:Feeling/model/movie.dart';

class Tmdb {
  static bool showChinese = false;
  static String imgHigh = '$imgPrefix/w780';
  static String imgNormal = '$imgPrefix/w500';
  static String baseUrl = 'https://api.themoviedb.org/';
  static String imgPrefix = "https://image.tmdb.org/t/p";

  static Dio client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      queryParameters: {
        "api_key": DotEnv().env['TMDB_AUTH_V3'],
        "language": "zh-CN",
        "region": "CN",
      },
    ),
  );

  static Future init() async {
    String locale = await Devicelocale.currentLocale;

    if (locale.indexOf('CN') > -1) {
      showChinese = true;
    }

    client.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: false,
        responseBody: false,
        responseHeader: false,
        requestHeader: false,
        compact: true,
      ),
    );

    // Proxy
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 127.0.0.1:1087";
      };
    };

    client.interceptors.add(
      DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor,
    );
  }

  static String _catchError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      return 'Connection timeout, please try again.';
    }
    return 'Request error, please try again.';
  }

  static Future getMovies({
    String type = 'upcoming',
    int page = 1,
    Options options,
  }) async {
    try {
      Response response = await client.get(
        '/3/movie/$type',
        queryParameters: {
          "page": page,
          "language": showChinese ? "zh-CN" : "en-US",
          "region": showChinese ? "CN" : "EN",
        },
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
      return _catchError(err);
    }
  }

  static Future getTrendingMovies({
    String time = 'day',
    int page = 1,
  }) async {
    try {
      Response response = await client.get(
        '/3/trending/movie/$time',
        queryParameters: {
          "page": page,
          "language": showChinese ? "zh-CN" : "en-US",
          "region": showChinese ? "CN" : "EN",
        },
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
      return _catchError(err);
    }
  }
}
