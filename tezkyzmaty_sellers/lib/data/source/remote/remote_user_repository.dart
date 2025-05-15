import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/api/api.dart';
import 'package:tezkyzmaty_sellers/core/api_response/api_response.dart';
import 'package:tezkyzmaty_sellers/core/constants/end_point.dart';
import 'package:tezkyzmaty_sellers/core/constants/status_code.dart';
import 'package:tezkyzmaty_sellers/core/dio_response/dio_base_response.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/auth.dart';
import 'package:tezkyzmaty_sellers/data/models/profile_model.dart';

abstract class RemoteUserRepository {
  Future<ApiResponse<Auth>> login(Map<String, dynamic>? params);

  Future<Either<Failure, ProfileModel?>> fetchProfile();

  Future<dynamic> signUp(Map<String, dynamic>? params);

  Future<dynamic> refreshToken({required Map<String, dynamic>? params});
  Future<bool?> verifyToken();

  Future<Either<Failure, ProfileModel?>> updateProfile({
    required Map<String, dynamic>? params,
  });
  Future<Either<Failure, ProfileModel?>> updatePassword({
    required Map<String, dynamic>? params,
  });

  Future<Either<Failure, ProfileModel?>> updateProfileFormData({
    required Map<String, dynamic>? params,
    File? avatar,
  });
  Future<Either<Failure, bool?>> otpSend({
    required Map<String, dynamic>? params,
  });
  Future<Either<Failure, ApiResponse<Auth>>> otpVerify({
    required Map<String, dynamic>? params,
  });

  Future<Either<Failure, bool?>> deleteAccount();

  Future<Either<Failure, bool?>> topUpBalance({Map<String, dynamic>? input});
  Future<Either<Failure, bool>> restorePassword({Map<String, dynamic>? input});
  Future<Either<Failure, bool>> enterNewPassword({Map<String, dynamic>? input});
  Future<Either<Failure, String>> otpVerifyRestorePassword({
    Map<String, dynamic>? input,
  });
}

@LazySingleton(as: RemoteUserRepository)
class RemoteUserRepositoryImpl implements RemoteUserRepository {
  RemoteUserRepositoryImpl({required this.apiClient});
  final Client apiClient;

  final EndPointConstant endPointConstant = EndPointConstant();
  @override
  Future<ApiResponse<Auth>> login(Map<String, dynamic>? params) async {
    final response = await apiClient.post(
      url: endPointConstant.login,
      data: params!,
      isNeedDefaultHeader: false,
    );

    if (response.statusCode == StatusCodeConstant.statusOK200) {
      return ApiResponse(
        data: Auth.fromJson(response.data as Map<String, dynamic>),
      );
    } else if (response.statusCode == StatusCodeConstant.statusBadRequest400) {
      throw NotFoundException(response.message);
    } else {
      throw ErrorException(message: response.message);
    }
  }

  @override
  Future<Either<Failure, bool?>> deleteAccount() async {
    final response = await apiClient.delete(
      url: endPointConstant.deleteProfileUrl,
    );
    if (response.statusCode == StatusCodeConstant.statusDeleted ||
        response.statusCode == StatusCodeConstant.statusOK200) {
      return const Right(true);
    } else if (response.statusCode == StatusCodeConstant.statusBadRequest400) {
      throw NotFoundException(response.message);
    } else {
      throw ErrorException(message: response.message);
    }
  }

  @override
  Future<Either<Failure, ApiResponse<Auth>>> otpVerify({
    Map<String, dynamic>? params,
  }) async {
    final response = await apiClient.post(
      url: endPointConstant.verifyCodeUrl,
      data: params!,
      isNeedDefaultHeader: false,
    );
    try {
      if (response.statusCode == StatusCodeConstant.statusOK200) {
        return Right(
          ApiResponse(
            data: Auth.fromJson(response.data as Map<String, dynamic>),
          ),
        );
      } else {
        if (response.statusCode == StatusCodeConstant.statusUnknown ||
            response.statusCode == StatusCodeConstant.statusBadRequest400) {
          final String errorMessage =
              (response.data != null &&
                      response.data['detail'] != null &&
                      response.data['detail'] is String)
                  ? response.data['detail'].toString()
                  : 'An error occurred, we are working on it';

          log('err = $errorMessage');
          return Left(Failure.notFoundFailure(errorMessage));
        }
        return const Left(Failure.notFoundFailure('Base Error'));
      }
    } catch (e) {
      String errorMessage = 'An error occurred, we are working on it';
      if (e is DioBaseResponse &&
          (e.statusCode == StatusCodeConstant.statusBadRequest400 ||
              e.statusCode == StatusCodeConstant.statusTooManyRequests) &&
          (e.data != null && e.data['detail'] != null)) {
        if (e.data['detail'] is String) {
          errorMessage = e.data['detail'].toString();
        }
        if (e.data['detail'] is List) {
          errorMessage = e.data['detail'][0].toString();
        }
      }

      log('err = $errorMessage');
      if (e is NotFoundException) {
        throw UnauthorizedException(errorMessage);
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(errorMessage));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(errorMessage));
    }
  }

  @override
  Future signUp(Map<String, dynamic>? params) async {
    final response = await apiClient.get(url: '', params: params);
    if (response.statusCode == StatusCodeConstant.statusOK200) {
      return ApiResponse(data: response.message);
    } else {
      throw const ErrorException(message: '');
    }
  }

  @override
  Future refreshToken({required Map<String, dynamic>? params}) async {
    final response = await apiClient.post(
      url: endPointConstant.refreshTokenUrl,
      data: params!,
    );
    if (response.statusCode == StatusCodeConstant.statusOK200) {
      return ApiResponse(data: response.message);
    } else {
      throw const ErrorException(message: '');
    }
  }

  @override
  Future<bool?> verifyToken() async {
    try {
      final response = await apiClient.post(
        url: endPointConstant.verifyTokenUrl,
        data: {},
        isNeedDefaultHeader: false,
        isVerifyToken: true,
      );

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        return true;
      } else {
        throw const ErrorException(message: '');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ProfileModel?>> updateProfile({
    required Map<String, dynamic>? params,
  }) async {
    try {
      final response = await apiClient.post(
        url: endPointConstant.profileUrl,
        data: params!,
      );

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        final profile = ProfileModel.fromMap(
          response.data as Map<String, dynamic>,
        );
        return Right(profile);
      } else {
        return Left(Failure.notFoundFailure(response.data?.toString() ?? ''));
      }
    } catch (e) {
      if (e is NotFoundException) {
        throw UnauthorizedException(e.message);
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(e.message!));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel?>> updatePassword({
    required Map<String, dynamic>? params,
  }) async {
    try {
      final response = await apiClient.put(
        url: endPointConstant.updatePasswordUrl,
        data: params!,
      );

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        final profile = ProfileModel.fromMap(
          response.data as Map<String, dynamic>,
        );
        return Right(profile);
      } else {
        return Left(Failure.notFoundFailure(response.data?.toString() ?? ''));
      }
    } catch (e) {
      if (e is NotFoundException) {
        throw UnauthorizedException(e.message);
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(e.message!));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel?>> updateProfileFormData({
    required Map<String, dynamic>? params,
    File? avatar,
  }) async {
    try {
      final response = await apiClient.postFormData(
        url: endPointConstant.profileUrl,
        data: params!,
        key: 'image',
        file: avatar != null ? [avatar] : [],
      );

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        final profile = ProfileModel.fromMap(
          response.data as Map<String, dynamic>,
        );
        return Right(profile);
      } else {
        return const Left(Failure.notFoundFailure('Base Error'));
      }
    } catch (e) {
      if (e is NotFoundException) {
        throw UnauthorizedException(e.message);
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(e.message!));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel?>> fetchProfile() async {
    try {
      final response = await apiClient.get(url: endPointConstant.profileUrl);

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        final profile = ProfileModel.fromMap(
          response.data as Map<String, dynamic>,
        );
        return Right(profile);
      } else {
        return const Left(Failure.notFoundFailure('Base Error'));
      }
    } catch (e) {
      if (e is NotFoundException) {
        throw UnauthorizedException(e.message);
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(e.message!));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool?>> otpSend({
    required Map<String, dynamic>? params,
  }) async {
    try {
      final response = await apiClient.post(
        url: endPointConstant.sendCodeUrl,
        data: params!,
        isNeedDefaultHeader: false,
      );

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        return const Right(true);
      } else {
        if (response.statusCode == StatusCodeConstant.statusUnknown) {
          final String errorMessage =
              (response.data != null &&
                      response.data['detail'] != null &&
                      response.data['detail'] is String)
                  ? response.data['detail'].toString()
                  : 'An error occurred, we are working on it';

          log('err = $errorMessage');
          return Left(Failure.notFoundFailure(errorMessage));
        }
        return const Left(Failure.notFoundFailure('Base Error'));
      }
    } catch (e) {
      String errorMessage = 'An error occurred, we are working on it';
      if (e is DioBaseResponse &&
          (e.statusCode == StatusCodeConstant.statusBadRequest400 ||
              e.statusCode == StatusCodeConstant.statusTooManyRequests) &&
          (e.data != null && e.data['detail'] != null)) {
        if (e.data['detail'] is String) {
          errorMessage = e.data['detail'].toString();
        }
        if (e.data['detail'] is List) {
          errorMessage = e.data['detail'][0].toString();
        }
      }

      log('err = $errorMessage');
      if (e is NotFoundException) {
        throw UnauthorizedException(errorMessage);
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(errorMessage));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool?>> topUpBalance({
    Map<String, dynamic>? input,
  }) async {
    final response = await apiClient.post(
      url: endPointConstant.topUpBalanceUrl,
      data: input!,
    );
    if (response.statusCode == StatusCodeConstant.statusDeleted ||
        response.statusCode == StatusCodeConstant.statusOK200) {
      return const Right(true);
    } else if (response.statusCode == StatusCodeConstant.statusBadRequest400) {
      throw NotFoundException(response.message);
    } else {
      throw ErrorException(message: response.message);
    }
  }

  @override
  Future<Either<Failure, bool>> enterNewPassword({
    Map<String, dynamic>? input,
  }) async {
    final response = await apiClient.post(
      url: endPointConstant.enterNewPasswordUrl,
      data: input!,
      isNeedDefaultHeader: false,
    );
    if (response.statusCode == StatusCodeConstant.statusDeleted ||
        response.statusCode == StatusCodeConstant.statusOK200) {
      return const Right(true);
    } else if (response.statusCode == StatusCodeConstant.statusBadRequest400) {
      throw NotFoundException(response.message);
    } else {
      throw ErrorException(message: response.message);
    }
  }

  @override
  Future<Either<Failure, String>> otpVerifyRestorePassword({
    Map<String, dynamic>? input,
  }) async {
    final response = await apiClient.post(
      url: endPointConstant.otpVerifyRestorePasswordUrl,
      data: input!,
      isNeedDefaultHeader: false,
    );
    if (response.statusCode == StatusCodeConstant.statusDeleted ||
        response.statusCode == StatusCodeConstant.statusOK200) {
      final responseData = response.data as Map<String, dynamic>;
      final resetPasswordToken = responseData['reset_password_token'];
      if (resetPasswordToken != null) {
        return Right(resetPasswordToken as String);
      } else {
        return const Left(
          Failure.notFoundFailure('Reset password token not found'),
        );
      }
    } else if (response.statusCode == StatusCodeConstant.statusBadRequest400) {
      throw NotFoundException(response.message);
    } else {
      throw ErrorException(message: response.message);
    }
  }

  @override
  Future<Either<Failure, bool>> restorePassword({
    Map<String, dynamic>? input,
  }) async {
    final response = await apiClient.post(
      url: endPointConstant.restorePasswordUrl,
      data: input!,
      isNeedDefaultHeader: false,
    );
    if (response.statusCode == StatusCodeConstant.statusDeleted ||
        response.statusCode == StatusCodeConstant.statusOK200) {
      return const Right(true);
    } else if (response.statusCode == StatusCodeConstant.statusBadRequest400) {
      throw NotFoundException(response.message);
    } else {
      throw ErrorException(message: response.message);
    }
  }
}
