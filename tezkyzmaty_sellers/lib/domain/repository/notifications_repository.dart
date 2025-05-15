import 'package:either_dart/either.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/notification_model.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, bool>> updateNotification({
    Map<String, dynamic>? input,
  });
  Future<Either<Failure, Notifys>> fetchNotifications();
}
