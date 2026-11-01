import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entites/notification_page_entity.dart';

abstract class NotificationRepositoryContract {
  Future<Either<Failure, NotificationsPageEntity>> getNotifications({
    required bool includeRead,
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, String?>> markAsRead({
    required String notificationId,
  });

  Future<Either<Failure, String?>> markNotificationsAsRead({
    required List<String> notificationIds,
  });
}
