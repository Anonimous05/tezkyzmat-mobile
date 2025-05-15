// ignore_for_file: only_throw_errors, no_default_cases

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/api/client.dart';
import 'package:tezkyzmaty_sellers/core/api/dio_factory.dart';
import 'package:tezkyzmaty_sellers/core/api_response/api_response.dart';
import 'package:tezkyzmaty_sellers/core/constants/end_point.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_general_constants.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_prefs_consts.dart';
import 'package:tezkyzmaty_sellers/core/dio_response/dio_response.dart';
import 'package:tezkyzmaty_sellers/core/services/global_storage_service.dart';
import 'package:tezkyzmaty_sellers/core/utils/base_utils.dart';
import 'package:tezkyzmaty_sellers/core/utils/logger.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';

@LazySingleton(as: Client)
class ClientImpl extends Client {
  @override
  Future<DioBaseResponse> downloadFile({
    Map<String, dynamic>? headers,
    ProgressCallback? progressCallback,
    bool processResponse = true,
    bool isNeedDefaultHeader = true,
    required String url,
    bool isRetry = false,
    required savePath,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {};

      if (isNeedDefaultHeader && token.isNotEmpty) {
        header.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=utf-8',
        });
      }

      header.addAll(headers ?? {});

      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.download(
        url,
        savePath,
        options: Options(headers: header),
        onReceiveProgress: progressCallback,
      );
      final httpResponse = _buildResponse(response);
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();

          return downloadFile(
            url: url,
            headers: headers,
            isRetry: true,
            savePath: savePath,
            isNeedDefaultHeader: isNeedDefaultHeader,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }
      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> delete({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool processResponse = true,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    required String url,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {};

      if (isNeedDefaultHeader) {
        header.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=utf-8',
        });
      }

      header.addAll(headers ?? {});
      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.delete(
        url,
        data: data,
        options: Options(headers: header),
        queryParameters: params,
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();
          return delete(
            url: url,
            params: params,
            headers: headers,
            isRetry: true,
            isNeedDefaultHeader: isNeedDefaultHeader,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }
      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> get({
    Duration? cacheAge,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
    bool isNeedDefaultHeader = true,
    Map<String, dynamic>? data,
    bool isRetry = false,
    required String url,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {};

      if (isNeedDefaultHeader && token.isNotEmpty) {
        header.addAll({
          'Authorization': 'Bearer $token',
          'Accept-Language': getLocaleFromPrefs(true),
          'Content-Type': 'application/json',
        });
      }
      log('url is $url');
      log('header is $header');

      header.addAll(headers ?? {});

      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.get(
        url,
        options: Options(headers: header),
        queryParameters: params,
        data: data,
      );

      final httpResponse = _buildResponse(response);
      if (processResponse) {}

      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();

          return get(
            url: url,
            headers: headers,
            params: params,
            isRetry: true,
            isNeedDefaultHeader: isNeedDefaultHeader,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }
      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> patch({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool isNeedDefaultHeader = true,
    bool processResponse = true,
    bool isRetry = false,
    required String url,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {};
      log('url is $url');
      log('header is $header');

      if (isNeedDefaultHeader) {
        header.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=utf-8',
        });

        if (token.isEmpty) {
          return throw const UnauthorizedException('send user to auth');
        }
      }
      log('url is $url');
      log('header is $header');

      header.addAll(headers ?? {});
      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.patch(
        url,
        data: data,
        options: Options(headers: header),
        queryParameters: params,
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();

          return patch(
            url: url,
            headers: headers,
            params: params,
            isNeedDefaultHeader: isNeedDefaultHeader,
            isRetry: true,
            data: data,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }
      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> post({
    Duration? cacheAge,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    bool isVerifyToken = false,
    required String url,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {
        'Content-Type': 'application/json; charset=utf-8',
      };

      if (isNeedDefaultHeader) {
        header.addAll({'Authorization': 'Bearer $token'});
        if (token.isEmpty) {
          return throw const UnauthorizedException('send user to auth');
        }
      }
      if (isVerifyToken) {
        if (token.isEmpty) {
          return throw const UnauthorizedException('send user to auth');
        }
        data = {'token': token};
      }

      header.addAll(headers ?? {});
      // log(data.toString());

      log('url is $url');

      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: header),
        queryParameters: params,
      );

      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();
          return post(
            url: url,
            headers: headers,
            data: data,
            params: params,
            isNeedDefaultHeader: isNeedDefaultHeader,
            isRetry: true,
            isVerifyToken: isVerifyToken,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }

      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      throw errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> postFormData({
    Duration? cacheAge,
    ProgressCallback? progressCallback,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
    bool isNeedDefaultHeader = true,
    bool isRetry = false,
    bool isVerifyToken = false,
    required String url,
    required String key,
    required List<File> file,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {
        'Content-Type': 'application/json; charset=utf-8',
      };

      if (isNeedDefaultHeader) {
        header.addAll({'Authorization': 'Bearer $token'});
        if (token.isEmpty) {
          return throw const UnauthorizedException('send user to auth');
        }
      }

      if (isVerifyToken) {
        if (token.isEmpty) {
          return throw const UnauthorizedException('send user to auth');
        }
        data = {'token': token};
      }

      header.addAll(headers ?? {});
      // log(data.toString());

      log('url is $url');
      final FormData formData = FormData();
      for (final item in file) {
        final String fileName = item.path.split('/').last;
        formData.files.add(
          MapEntry(
            key,
            await MultipartFile.fromFile(item.path, filename: fileName),
          ),
        );
      }
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: header),
        onReceiveProgress: progressCallback,
      );

      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();
          return post(
            url: url,
            headers: headers,
            data: data,
            params: params,
            isNeedDefaultHeader: isNeedDefaultHeader,
            isRetry: true,
            isVerifyToken: isVerifyToken,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }

      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      throw errResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DioBaseResponse> put({
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool processResponse = true,
    bool isRetry = false,
    bool isNeedDefaultHeader = true,
    required String url,
  }) async {
    try {
      final String token =
          await Storage().secureStorage.read(
            key: GlobalPrefsConst.accessToken,
          ) ??
          GlobalGeneralConsts.empty;
      final Map<String, dynamic> header = {};

      if (isNeedDefaultHeader) {
        header.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=utf-8',
        });
        if (token.isEmpty) {
          return throw const UnauthorizedException('send user to auth');
        }
      }

      header.addAll(headers ?? {});

      final Dio dio = await DioClient(baseURL: url, dio: Dio()).getDio();

      final response = await dio.put(
        url,
        data: data,
        options: Options(headers: header),
        queryParameters: params,
      );
      final httpResponse = _buildResponse(response);
      if (processResponse) {}
      return httpResponse;
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        if (!isRetry) {
          await refreshToken();
          return put(
            url: url,
            headers: headers,
            params: params,
            isRetry: true,
            isNeedDefaultHeader: isNeedDefaultHeader,
            data: data,
          );
        }
        throw const UnauthorizedException('send user to auth');
      }
      final errResponse = await _buildResponseWithError(e, stackTrace);
      if (processResponse && e.response != null) {}
      return errResponse;
    } catch (e) {
      rethrow;
    }
  }

  DioBaseResponse _buildResponse(Response response) {
    return DioBaseResponse(
      data: response.data,
      statusCode: response.statusCode ?? 400,
    );
  }

  Future<DioBaseResponse> _buildResponseWithError(
    DioException error,
    StackTrace stackTrace,
  ) async {
    if (error.response?.statusCode != 400 ||
        error.response?.statusCode != 401) {
      final Logger logger = getIt<Logger>();

      logger.talker.error('_buildResponseWithError', error.error, stackTrace);

      // await Sentry.captureException(
      //   error,
      //   stackTrace: stackTrace,
      // );
    }

    return DioBaseResponse(
      data: error.response?.data,
      //DIO ERROR SO ITS AN ERROR FROM RESPONSE OF THE API OR FROM DIO ITSELF
      message: _dioError(error),
      statusCode: error.response?.statusCode ?? 400,
    );
  }

  @override
  Future<void> refreshToken() async {
    String token = '';
    token =
        await Storage().secureStorage.read(
          key: GlobalPrefsConst.refreshToken,
        ) ??
        GlobalGeneralConsts.empty;

    if (token.isEmpty) {
      throw const UnauthorizedException('send user to auth');
    }
    final Map<String, dynamic> payload = {'refresh': token};
    try {
      final Dio dio =
          await DioClient(
            baseURL: EndPointConstant().refreshTokenUrl,
            dio: Dio(),
          ).getDio();

      final response = await dio.post(
        EndPointConstant().refreshTokenUrl,
        data: payload,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw const UnauthorizedException('send user to auth');
      }
      await Storage().secureStorage.write(
        key: GlobalPrefsConst.accessToken,
        value: response.data['access'] as String,
      );
    } catch (e) {
      throw const UnauthorizedException('send user to auth');
    }
  }
}

String? _dioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timed out';

    case DioExceptionType.sendTimeout:
      return 'Request timed out';

    case DioExceptionType.receiveTimeout:
      return 'Response timeout';

    case DioExceptionType.unknown:
      return 'Unknown error';

    case DioExceptionType.connectionError:
      return 'No internet connection';

    case DioExceptionType.cancel:
      return 'request cancelled';

    case DioExceptionType.badCertificate:
      return 'bad certificate';

    case DioExceptionType.badResponse:
      try {
        final int? errCode = error.response?.statusCode;
        switch (errCode) {
          case 400:
            return 'Request timed out'; //dioRequestSyntax

          case 403:
            return 'Server refused to execute'; //dioServerRefusedToExecute

          case 404:
            return 'Server refused to execute'; //dioNotConnectServer

          case 405:
            return 'Request method is forbidden'; //dioRequestForbidden

          case 500:
            return 'Server internal error'; //dioServerInternal

          case 502:
            return 'Invalid request'; //dioInvalidRequest

          case 503:
            return 'Server is down'; //dioServerDown

          case 505:
            return 'Does not support HTTP protocol request'; //dioHttpNotSupport

          default:
            return 'Unknown mistake'; //dioUnknownMistake
        }
      } on Exception catch (_) {
        return 'Unknown error'; //dioUnknownError
      }
  }
}

Future<void> processResponse(DioBaseResponse response) async {
  if (response.statusCode == 401) {}
}
