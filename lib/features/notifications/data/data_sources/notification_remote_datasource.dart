import 'package:dio/dio.dart';
import 'package:store/core/errors/api_error_handler.dart';
import '../models/notification_page_model.dart';

abstract class BaseNotificationRemoteDataSource {
  Future<NotificationsPageModel> getNotifications({
    required bool includeRead,
    required int page,
    required int pageSize,
  });

  Future<String?> markAsRead({
    required String notificationId,
  });

  Future<String?> markNotificationsAsRead({
    required List<String> notificationIds,
  });
}

class NotificationRemoteDataSource extends BaseNotificationRemoteDataSource {
  final Dio dio;

  NotificationRemoteDataSource({required this.dio});

  @override
  Future<NotificationsPageModel> getNotifications({
    required bool includeRead,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await dio.get(
        '/api/notifications',
        queryParameters: {
          'includeRead': includeRead,
          'page': page,
          'pageSize': pageSize,
        },
      );

      return NotificationsPageModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<String?> markAsRead({
    required String notificationId,
  }) async {
    try {
      final response = await dio.post(
        '/api/notifications/$notificationId/read',
      );

      return response.data['message'] as String?;
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }

  @override
  Future<String?> markNotificationsAsRead({
    required List<String> notificationIds,
  }) async {
    try {
      final response = await dio.post(
        '/api/notifications/bulk-read',
        data: {
          'notificationIds': notificationIds,
        },
      );

      return response.data['message'] as String?;
    } on DioException catch (exception) {
      throw ApiErrorHandler().handle(exception);
    }
  }
}
