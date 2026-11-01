import '../../domain/entites/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required String id,
    required String notificationText,
    required DateTime createdAt,
    required bool isRead,
  }) : super(
          id: id,
          notificationText: notificationText,
          createdAt: createdAt,
          isRead: isRead,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      notificationText: json['notificationText'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
    );
  }
}
