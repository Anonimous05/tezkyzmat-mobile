// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tezkyzmaty_sellers/core/error/error_exception.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/auth.dart';
import 'package:tezkyzmaty_sellers/data/models/profile_model.dart';
import 'package:tezkyzmaty_sellers/data/source/local/local_user_repository.dart';
import 'package:tezkyzmaty_sellers/data/source/remote/remote_user_repository.dart';
import 'package:tezkyzmaty_sellers/domain/entities/profile_entity.dart';
import 'package:tezkyzmaty_sellers/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required this.remoteUserRepository,
    required this.localUserRepository,
  });
  final RemoteUserRepository remoteUserRepository;
  final LocalUserRepository localUserRepository;

  @override
  Future<Either<Failure, bool?>> deleteAccount() async {
    try {
      final response = await remoteUserRepository.deleteAccount();
      if (response.isRight) {
        return Right(response.right);
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, bool?>> topUpBalance({
    Map<String, dynamic>? input,
  }) async {
    try {
      final response = await remoteUserRepository.topUpBalance(input: input);
      if (response.isRight) {
        return Right(response.right);
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, Auth>> login({Map<String, dynamic>? input}) async {
    try {
      final response = await remoteUserRepository.login(input);
      if (response.data != null) {
        return Right(response.data!);
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, Auth>> otpVerify({Map<String, dynamic>? input}) async {
    try {
      final response = await remoteUserRepository.otpVerify(params: input);
      if (response.isRight) {
        return Right(response.right.data!);
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyToken() async {
    try {
      final response = await remoteUserRepository.verifyToken();

      if (response == true) {
        return const Right(true);
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      log(exception.toString());

      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      log(exception.toString());

      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    Map<String, dynamic>? input,
  }) async {
    log(input.toString());
    try {
      final response = await remoteUserRepository.updateProfile(params: input);
      if (response.isRight) {
        await localUserRepository.saveProfile(profile: response.right!);
        return Right(response.right!.toDomain());
      }

      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updatePassword({
    Map<String, dynamic>? input,
  }) async {
    log(input.toString());
    try {
      final response = await remoteUserRepository.updatePassword(params: input);
      if (response.isRight) {
        await localUserRepository.saveProfile(profile: response.right!);
        return Right(response.right!.toDomain());
      }

      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfileFormData({
    Map<String, dynamic>? input,
    File? avatar,
  }) async {
    try {
      final response = await remoteUserRepository.updateProfileFormData(
        params: input,
        avatar: avatar,
      );
      if (response.isRight) {
        await localUserRepository.saveProfile(profile: response.right!);
        return Right(response.right!.toDomain());
      }

      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> fetchProfile() async {
    final bool hasInternetAccess = await InternetConnection().hasInternetAccess;
    if (hasInternetAccess) {
      try {
        final response = await remoteUserRepository.fetchProfile();
        if (response.isRight) {
          await localUserRepository.saveProfile(profile: response.right!);
          return Right(response.right!.toDomain());
        }
        return const Left(Failure.notFoundFailure('Error'));
      } on UnauthorizedException {
        rethrow;
      } on NotFoundException catch (exception) {
        return Left(Failure.notFoundFailure(exception.message!));
      } on ErrorException catch (exception) {
        return Left(Failure.errorFailure(exception.message!));
      }
    }
    try {
      final response = await localUserRepository.fetchProfile();
      if (response.isRight) {
        return Right(response.right!.toDomain());
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> otpSend({Map<String, dynamic>? input}) async {
    try {
      final response = await remoteUserRepository.otpSend(params: input);
      if (response.isRight) {
        return const Right(true);
      }
      if (response.isLeft) {
        return Left(Failure.notFoundFailure(response.left.message));
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> enterNewPassword({
    Map<String, dynamic>? input,
  }) async {
    try {
      final response = await remoteUserRepository.enterNewPassword(
        input: input,
      );
      if (response.isRight) {
        return const Right(true);
      }
      if (response.isLeft) {
        return Left(Failure.notFoundFailure(response.left.message));
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, String>> otpVerifyRestorePassword({
    Map<String, dynamic>? input,
  }) async {
    try {
      final response = await remoteUserRepository.otpVerifyRestorePassword(
        input: input,
      );
      if (response.isRight) {
        return Right(response.right);
      }
      if (response.isLeft) {
        return Left(Failure.notFoundFailure(response.left.message));
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> restorePassword({
    Map<String, dynamic>? input,
  }) async {
    try {
      final response = await remoteUserRepository.restorePassword(input: input);
      if (response.isRight) {
        return const Right(true);
      }
      if (response.isLeft) {
        return Left(Failure.notFoundFailure(response.left.message));
      }
      if (response.isLeft) {
        return Left(Failure.notFoundFailure(response.left.message));
      }
      return const Left(Failure.notFoundFailure('Error'));
    } on UnauthorizedException {
      rethrow;
    } on NotFoundException catch (exception) {
      return Left(Failure.notFoundFailure(exception.message!));
    } on ErrorException catch (exception) {
      return Left(Failure.errorFailure(exception.message!));
    }
  }
}
