import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:store/features/notifications/domain/usecases/mark_all_notifications_as_read_usecase.dart';
import 'package:store/features/notifications/domain/usecases/mark_notification_as_read_usecase.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;
  final MarkAllNotificationAsReadUseCase markNotificationsAsReadUseCase;
  int currentPage = 1;
  int currentPageSize = 10;
  bool currentIncludeRead = true;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markNotificationAsReadUseCase,
    required this.markNotificationsAsReadUseCase,
  }) : super(NotificationInitialState()) {
    on<GetNotificationsEvent>((event, emit) async {
      currentPage = event.page;
      currentPageSize = event.pageSize;
      currentIncludeRead = event.includeRead;

      emit(NotificationsLoadingState());

      final result = await getNotificationsUseCase.execute(
        includeRead: currentIncludeRead,
        page: currentPage,
        pageSize: currentPageSize,
      );

      result.fold(
            (failure) => emit(
          NotificationsFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
            (notificationsPage) => emit(
          NotificationsSuccessState(
            notificationsPage: notificationsPage,
          ),
        ),
      );
    });

    on<MarkNotificationAsReadEvent>((event, emit) async {
      emit(MarkNotificationAsReadLoadingState());

      final result = await markNotificationAsReadUseCase.execute(
        notificationId: event.notificationId,
      );

      result.fold(
        (failure) => emit(
          MarkNotificationAsReadFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (message) => emit(
          MarkNotificationAsReadSuccessState(message: message),
        ),
      );
    });

    on<MarkNotificationsAsReadEvent>((event, emit) async {
      emit(MarkNotificationsAsReadLoadingState());

      final result = await markNotificationsAsReadUseCase.execute(
        notificationIds: event.notificationIds,
      );

      result.fold(
        (failure) => emit(
          MarkNotificationsAsReadFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (message) => emit(
          MarkNotificationsAsReadSuccessState(message: message),
        ),
      );
    });
  }
}
