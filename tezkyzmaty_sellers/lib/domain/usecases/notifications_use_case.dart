import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/notification_model.dart';
import 'package:tezkyzmaty_sellers/domain/repository/notifications_repository.dart';

@LazySingleton()
class NotificationsUseCase {
  NotificationsUseCase(this.repository);
  final NotificationsRepository repository;

  Future<Either<Failure, bool>> updateNotification({
    Map<String, dynamic>? input,
  }) async {
    return repository.updateNotification(input: input);
  }

  Future<Either<Failure, Notifys>> fetchNotifications({
    Map<String, dynamic>? input,
  }) async {
    return repository.fetchNotifications();
  }
}
