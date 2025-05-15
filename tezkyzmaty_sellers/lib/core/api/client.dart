import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tezkyzmaty_sellers/core/dio_response/dio_response.dart';

abstract class Client {
  Future<DioBaseResponse> get({
    Duration? cacheAge,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    Map<String, dynamic>? data,
    required String url,
  });

  Future<DioBaseResponse> patch({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    required String url,
  });

  Future<DioBaseResponse> post({
    Duration? cacheAge,
    Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    bool isVerifyToken = false,
    required String url,
  });

  Future<DioBaseResponse> postFormData({
    Duration? cacheAge,
    ProgressCallback? progressCallback,
    Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    bool isVerifyToken = false,
    required String key,
    required String url,
    required List<File> file,
  });

  Future<DioBaseResponse> put({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    required String url,
  });

  Future<DioBaseResponse> delete({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    required String url,
  });

  Future<DioBaseResponse> downloadFile({
    Map<String, dynamic>? headers,
    ProgressCallback? progressCallback,
    required String url,
    bool isRetry = false,
    bool isNeedDefaultHeader = true,
    required savePath,
  });

  Future<void> refreshToken();
}
