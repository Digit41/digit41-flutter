import 'package:dio/dio.dart';

import 'routes.dart';

class DioSingleton {
  static Dio? _dio;

  DioSingleton._internal();

  static Dio? getInstance() {
    if (_dio == null)
      _dio = Dio(
        BaseOptions(
          baseUrl: Routes.BASE_URL,
          connectTimeout: 20000,
          receiveTimeout: 20000,
        ),
      );

    return _dio;
  }
}
