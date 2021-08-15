import 'package:dio/dio.dart';

import 'dio_singleton.dart';

Future anyApi({
  required String method,
  required String url,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParam,
  Map<String, dynamic>? header,
  bool isLogin = false,
}) async {
  try {
    Dio? dio = DioSingleton.getInstance();
    dio!.options.method = method.toLowerCase();
    if (header != null) dio.options.headers = header;
    Response response = await dio.request(
      url,
      data: data,
      queryParameters: queryParam,
    );

    if (response.statusCode == 200 && response.data != null) {
      Map json = response.data;
      if (json['status'])
        return json['data'];
      else
        return json['message'];
    }
  }catch (e) {
    print('==================================================================');
    print(('something was problem for $url: ' + e.toString()));
    print('==================================================================');
    throw e;
  }
}