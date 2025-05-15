import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/domain/entities/entities.dart';
import 'package:tezkyzmaty_sellers/domain/repository/user_repository.dart';

@LazySingleton()
class UserUseCase {
  UserUseCase(this.repository);
  final UserRepository repository;

  Future<Either<Failure, ProfileEntity?>> updateProfile({
    Map<String, dynamic>? input,
  }) async {
    return repository.updateProfile(input: input);
  }

  Future<Either<Failure, ProfileEntity?>> updatePassword({
    Map<String, dynamic>? input,
  }) async {
    return repository.updatePassword(input: input);
  }

  Future<Either<Failure, ProfileEntity?>> updateProfileFormData({
    Map<String, dynamic>? input,
    File? avatar,
  }) async {
    return repository.updateProfileFormData(input: input, avatar: avatar);
  }

  Future<Either<Failure, ProfileEntity?>> fetchProfile({
    Map<String, dynamic>? input,
  }) async {
    return repository.fetchProfile();
  }

  Future<Either<Failure, bool?>> deleteAccount() async {
    return repository.deleteAccount();
  }

  Future<Either<Failure, bool?>> topUpBalance({
    Map<String, dynamic>? input,
  }) async {
    return repository.topUpBalance(input: input);
  }


  Future<Either<Failure, bool>> verifyToken() async {
    final verifyValue = await repository.verifyToken();
    if (verifyValue.isRight) {
      return const Right(true);
    }

    return verifyValue;
  }
}
