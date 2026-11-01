import 'package:equatable/equatable.dart';
import 'notification_entity.dart';

class NotificationsPageEntity extends Equatable {
  final List<NotificationEntity> notifications;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const NotificationsPageEntity({
    required this.notifications,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [
        notifications,
        page,
        pageSize,
        totalCount,
        hasNextPage,
        hasPreviousPage,
      ];
}
