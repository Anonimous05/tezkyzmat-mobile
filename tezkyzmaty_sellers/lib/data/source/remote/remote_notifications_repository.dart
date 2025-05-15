import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/api/api.dart';
import 'package:tezkyzmaty_sellers/core/api_response/api_response.dart';
import 'package:tezkyzmaty_sellers/core/constants/end_point.dart';
import 'package:tezkyzmaty_sellers/core/constants/status_code.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/notification_model.dart';

abstract class RemoteNotificationsRepository {
  Future<Either<Failure, Notifys>> fetchNotifications();

  Future<Either<Failure, bool>> updateNotification({
    required Map<String, dynamic>? params,
  });
}

@LazySingleton(as: RemoteNotificationsRepository)
class RemoteNotificationsRepositoryImpl
    implements RemoteNotificationsRepository {
  RemoteNotificationsRepositoryImpl({required this.apiClient});
  final Client apiClient;

  final EndPointConstant endPointConstant = EndPointConstant();

  @override
  Future<Either<Failure, bool>> updateNotification({
    required Map<String, dynamic>? params,
  }) async {
    try {
      if (params?['id'] == null) {
        return const Right(false);
      }
      final url =
          '${endPointConstant.notificationUrl}${params?['id'] ?? 0}/read/';
      final response = await apiClient.post(url: url, data: {});

      if (response.statusCode == StatusCodeConstant.statusOK200 ||
          response.statusCode == StatusCodeConstant.statusCreated) {
        return const Right(true);
      } else {
        return const Right(false);
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
  Future<Either<Failure, Notifys>> fetchNotifications() async {
    try {
      final response = await apiClient.get(
        url: endPointConstant.notificationUrl,
      );

      if (response.statusCode == StatusCodeConstant.statusOK200) {
        final notifications = Notifys.fromMap(response.data as List);
        return Right(notifications);
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
}
