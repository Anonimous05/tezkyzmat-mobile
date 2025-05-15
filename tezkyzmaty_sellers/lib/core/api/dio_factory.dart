import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  DioClient({required this.dio, required this.baseURL});
  late String baseURL;
  late Dio dio;

  Future<Dio> getDio() async {
    dio.options = BaseOptions(baseUrl: baseURL);

    if (!kReleaseMode) {
      // ITS DEBUG MODE SO PRINT APP LOGS
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
