import '../../domain/entites/notification_page_entity.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationsLoadingState extends NotificationState {}

class NotificationsSuccessState extends NotificationState {
  final NotificationsPageEntity notificationsPage;

  NotificationsSuccessState({
    required this.notificationsPage,
  });
}

class NotificationsFailureState extends NotificationState {
  final String errorMessage;

  NotificationsFailureState({
    required this.errorMessage,
  });
}

class MarkNotificationAsReadLoadingState extends NotificationState {}

class MarkNotificationAsReadSuccessState extends NotificationState {
  final String? message;

  MarkNotificationAsReadSuccessState({this.message});
}

class MarkNotificationAsReadFailureState extends NotificationState {
  final String errorMessage;

  MarkNotificationAsReadFailureState({
    required this.errorMessage,
  });
}

class MarkNotificationsAsReadLoadingState extends NotificationState {}

class MarkNotificationsAsReadSuccessState extends NotificationState {
  final String? message;

  MarkNotificationsAsReadSuccessState({this.message});
}

class MarkNotificationsAsReadFailureState extends NotificationState {
  final String errorMessage;

  MarkNotificationsAsReadFailureState({
    required this.errorMessage,
  });
}
