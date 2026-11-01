import 'package:dartz/dartz.dart';
import 'package:store/core/errors/failures.dart';
import '../entites/notification_page_entity.dart';
import '../repos/notification_repository_contract.dart';

class GetNotificationsUseCase {
  final NotificationRepositoryContract repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, NotificationsPageEntity>> execute({
    required bool includeRead,
    required int page,
    required int pageSize,
  }) {
    return repository.getNotifications(
      includeRead: includeRead,
      page: page,
      pageSize: pageSize,
    );
  }
}
