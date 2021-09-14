import 'package:dio/dio.dart';

Dio apiCall() {
  var _dio = Dio();
  _dio
    ..options.baseUrl = 'https://si-bima.com/api'
    ..options.connectTimeout = 60 * 2000;

  return _dio;
}
