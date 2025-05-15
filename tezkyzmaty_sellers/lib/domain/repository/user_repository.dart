import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/auth.dart';
import 'package:tezkyzmaty_sellers/domain/entities/entities.dart';

abstract class UserRepository {
  Future<Either<Failure, Auth>> login({Map<String, dynamic>? input});

  Future<Either<Failure, ProfileEntity>> updateProfile({
    Map<String, dynamic>? input,
  });
  Future<Either<Failure, ProfileEntity>> updatePassword({
    Map<String, dynamic>? input,
  });
  Future<Either<Failure, ProfileEntity>> updateProfileFormData({
    Map<String, dynamic>? input,
    File? avatar,
  });

  Future<Either<Failure, ProfileEntity>> fetchProfile();
  Future<Either<Failure, bool>> verifyToken();
  Future<Either<Failure, bool>> otpSend({Map<String, dynamic>? input});

  Future<Either<Failure, Auth>> otpVerify({Map<String, dynamic>? input});
  Future<Either<Failure, bool?>> deleteAccount();
  Future<Either<Failure, bool?>> topUpBalance({Map<String, dynamic>? input});
  Future<Either<Failure, bool>> restorePassword({Map<String, dynamic>? input});
  Future<Either<Failure, bool>> enterNewPassword({Map<String, dynamic>? input});
  Future<Either<Failure, String>> otpVerifyRestorePassword({
    Map<String, dynamic>? input,
  });

}
