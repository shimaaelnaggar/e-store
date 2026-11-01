import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';

import '../repos/notification_repository_contract.dart';

class MarkAllNotificationAsReadUseCase {
  final NotificationRepositoryContract repository;

  MarkAllNotificationAsReadUseCase({required this.repository});

  Future<Either<Failure, String?>> execute({
    required List<String> notificationIds,
  }) {
    return repository.markNotificationsAsRead(
      notificationIds: notificationIds,
    );
  }
}
