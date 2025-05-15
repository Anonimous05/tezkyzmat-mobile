// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/error/error_exception.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/notification_model.dart';
import 'package:tezkyzmaty_sellers/data/source/remote/remote_notifications_repository.dart';
import 'package:tezkyzmaty_sellers/domain/repository/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({required this.remoteNotificationsRepository});
  final RemoteNotificationsRepository remoteNotificationsRepository;

  @override
  Future<Either<Failure, bool>> updateNotification({
    Map<String, dynamic>? input,
  }) async {
    log(input.toString());
    try {
      final response = await remoteNotificationsRepository.updateNotification(
        params: input,
      );
      if (response.isRight && response.right) {
        return const Right(true);
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
  Future<Either<Failure, Notifys>> fetchNotifications() async {
    try {
      final response = await remoteNotificationsRepository.fetchNotifications();
      if (response.isRight) {
        return Right(response.right);
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
