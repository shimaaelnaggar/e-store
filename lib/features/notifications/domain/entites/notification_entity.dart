import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String notificationText;
  final DateTime createdAt;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.notificationText,
    required this.createdAt,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
        id,
        notificationText,
        createdAt,
        isRead,
      ];
}
