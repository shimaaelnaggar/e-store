import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';

import '../repos/notification_repository_contract.dart';

class MarkNotificationAsReadUseCase {
  final NotificationRepositoryContract repository;

  MarkNotificationAsReadUseCase({required this.repository});

  Future<Either<Failure, String?>> execute({
    required String notificationId,
  }) {
    return repository.markAsRead(
      notificationId: notificationId,
    );
  }
}
