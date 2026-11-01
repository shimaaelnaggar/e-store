import '../../domain/entites/notification_entity.dart';
import '../../domain/entites/notification_page_entity.dart';
import 'notification_model.dart';

class NotificationsPageModel extends NotificationsPageEntity {
  const NotificationsPageModel({
    required List<NotificationEntity> notifications,
    required int page,
    required int pageSize,
    required int totalCount,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) : super(
          notifications: notifications,
          page: page,
          pageSize: pageSize,
          totalCount: totalCount,
          hasNextPage: hasNextPage,
          hasPreviousPage: hasPreviousPage,
        );

  factory NotificationsPageModel.fromJson(Map<String, dynamic> json) {
    final notificationsData = json['notifications'];

    return NotificationsPageModel(
      notifications: (notificationsData['items'] as List)
          .map(
            (item) => NotificationModel.fromJson(item),
          )
          .toList(),
      page: notificationsData['page'],
      pageSize: notificationsData['pageSize'],
      totalCount: notificationsData['totalCount'],
      hasNextPage: notificationsData['hasNextPage'],
      hasPreviousPage: notificationsData['hasPreviousPage'],
    );
  }
}
