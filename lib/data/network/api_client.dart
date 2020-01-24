import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../const/api_const.dart';

Dio _createClient() {
  BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: 10000,
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

  return client;
}

final Dio ApiClient = _createClient();
