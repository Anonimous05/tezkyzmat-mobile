import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/auth.dart';
import 'package:tezkyzmaty_sellers/domain/repository/user_repository.dart';

@LazySingleton()
class LoginUseCase {
  LoginUseCase(this.repository);
  final UserRepository repository;
  Future<Either<Failure, Auth>> login({Map<String, dynamic>? input}) async {
    return repository.login(input: input);
  }

  Future<Either<Failure, Auth>> otpVerify({Map<String, dynamic>? input}) async {
    return repository.otpVerify(input: input);
  }

  Future<Either<Failure, bool>> otpSend({Map<String, dynamic>? input}) async {
    return repository.otpSend(input: input);
  }

  Future<Either<Failure, bool>> restorePassword({
    Map<String, dynamic>? input,
  }) async {
    return repository.restorePassword(input: input);
  }

  Future<Either<Failure, bool>> enterNewPassword({
    Map<String, dynamic>? input,
  }) async {
    return repository.enterNewPassword(input: input);
  }

  Future<Either<Failure, String>> otpVerifyRestorePassword({
    Map<String, dynamic>? input,
  }) async {
    return repository.otpVerifyRestorePassword(input: input);
  }
}
