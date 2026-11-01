import 'package:dartz/dartz.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/errors/failures.dart';
import 'package:store/core/errors/map_exception_to_failure.dart';

import '../../domain/entites/notification_page_entity.dart';
import '../../domain/repos/notification_repository_contract.dart';
import '../data_sources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepositoryContract {
  final BaseNotificationRemoteDataSource dataSource;

  NotificationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, NotificationsPageEntity>> getNotifications({
    required bool includeRead,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await dataSource.getNotifications(
        includeRead: includeRead,
        page: page,
        pageSize: pageSize,
      );

      return right(response);
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, String?>> markAsRead({
    required String notificationId,
  }) async {
    try {
      final response = await dataSource.markAsRead(
        notificationId: notificationId,
      );

      return right(response);
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }

  @override
  Future<Either<Failure, String?>> markNotificationsAsRead({
    required List<String> notificationIds,
  }) async {
    try {
      final response = await dataSource.markNotificationsAsRead(
        notificationIds: notificationIds,
      );

      return right(response);
    } on AppException catch (exception) {
      return left(mapExceptionToFailure(exception));
    }
  }
}
