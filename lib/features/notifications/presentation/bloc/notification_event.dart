abstract class NotificationEvent {}

class GetNotificationsEvent extends NotificationEvent {
  final bool includeRead;
  final int page;
  final int pageSize;

  GetNotificationsEvent({
    this.includeRead = true,
    this.page = 1,
    this.pageSize = 10,
  });
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String notificationId;

  MarkNotificationAsReadEvent({
    required this.notificationId,
  });
}

class MarkNotificationsAsReadEvent extends NotificationEvent {
  final List<String> notificationIds;

  MarkNotificationsAsReadEvent({
    required this.notificationIds,
  });
}
