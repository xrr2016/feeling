import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../../const/api_const.dart';

Dio _createClient() {
  BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: 20000,
    receiveTimeout: 3000,
    queryParameters: {
      "api_key": DotEnv().env['TMDB_AUTH_V3'],
    },
  );

  Dio client = Dio(options);

  client.interceptors.add(PrettyDioLogger(
    error: true,
    request: false,
    responseBody: false,
    responseHeader: false,
    requestHeader: false,
    compact: true,
  ));

  (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.findProxy = (uri) {
      return "PROXY 127.0.0.1:1087";
    };
  };

  client.interceptors.add(
    DioCacheManager(CacheConfig(baseUrl: BASE_URL)).interceptor,
  );

  return client;
}

final Dio apiClient = _createClient();
