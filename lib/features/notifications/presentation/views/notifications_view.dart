import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/constants/app_text_styles.dart';
import 'package:store/core/widgets/app_top_bar.dart';
import 'package:store/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:store/features/notifications/presentation/bloc/notification_event.dart';
import 'package:store/features/notifications/presentation/bloc/notification_state.dart';

import '../../../../core/helper/show_message.dart';
import '../../../home/presentation/widgets/pagination_buttons.dart';
import '../../domain/entites/notification_entity.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(
              title: 'Notifications',
              showActions: false,
            ),
            Expanded(
              child: BlocConsumer<NotificationBloc, NotificationState>(
                listener: (context, state) {
                  if (state is MarkNotificationAsReadSuccessState ||
                      state is MarkNotificationsAsReadSuccessState) {
                    final bloc = context.read<NotificationBloc>();

                    bloc.add(
                      GetNotificationsEvent(
                        includeRead: bloc.currentIncludeRead,
                        page: bloc.currentPage,
                        pageSize: bloc.currentPageSize,
                      ),
                    );
                  }

                  if (state is MarkNotificationAsReadFailureState) {
                    showMessage(
                      context: context,
                      message: state.errorMessage,
                      backgroundColor: AppColors.errorColor,
                    );
                  }

                  if (state is MarkNotificationsAsReadFailureState) {
                    showMessage(
                      context: context,
                      message: state.errorMessage,
                      backgroundColor: AppColors.errorColor,
                    );
                  }

                  if (state is NotificationsFailureState) {
                    showMessage(
                      context: context,
                      message: state.errorMessage,
                      backgroundColor: AppColors.errorColor,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is NotificationsLoadingState ||
                      state is MarkNotificationAsReadLoadingState ||
                      state is MarkNotificationsAsReadLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (state is NotificationsFailureState ||
                      state is MarkNotificationAsReadFailureState ||
                      state is MarkNotificationsAsReadFailureState) {
                    return Center(
                      child: Text(
                        'Something went wrong. Please try again.',
                        style: AppTextStyles.bodyMedium,
                      ),
                    );
                  }

                  if (state is NotificationsSuccessState) {
                    final notificationsPage = state.notificationsPage;
                    final notifications = notificationsPage.notifications;

                    final unreadNotifications = notifications
                        .where((notification) => !notification.isRead)
                        .toList();

                    if (notifications.isEmpty) {
                      return Center(
                        child: Text(
                          'No notifications yet',
                          style: AppTextStyles.bodyMedium,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        if (unreadNotifications.isNotEmpty)
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              onPressed: () {
                                context.read<NotificationBloc>().add(
                                      MarkNotificationsAsReadEvent(
                                        notificationIds: unreadNotifications
                                            .map((item) => item.id)
                                            .toList(),
                                      ),
                                    );
                              },
                              child: Text(
                                'Mark all as read',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              final notification = notifications[index];

                              return _NotificationCard(
                                notification: notification,
                                onMarkAsRead: () {
                                  context.read<NotificationBloc>().add(
                                        MarkNotificationAsReadEvent(
                                          notificationId: notification.id,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        ),
                        PaginationButtons(
                          currentPage: notificationsPage.page,
                          hasNextPage: notificationsPage.hasNextPage,
                          hasPreviousPage: notificationsPage.hasPreviousPage,
                          totalCount: notificationsPage.totalCount,
                          pageSize: notificationsPage.pageSize,
                          itemLabel: 'notifications',
                          onPageChanged: (page) {
                            context.read<NotificationBloc>().add(
                                  GetNotificationsEvent(
                                    includeRead: true,
                                    page: page,
                                    pageSize: notificationsPage.pageSize,
                                  ),
                                );
                          },
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onMarkAsRead;

  const _NotificationCard({
    required this.notification,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.inputFillColor : AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.inputBorderColor.withAlpha(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryColor,
              size: 22.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.notificationText,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: isUnread ? FontWeight.w700 : FontWeight.normal,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  _formatDate(notification.createdAt),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondaryColor,
                    fontSize: 11.sp,
                  ),
                ),
                if (isUnread) ...[
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: onMarkAsRead,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Mark as Read'),
                  ),
                ],
              ],
            ),
          ),
          if (isUnread) ...[
            SizedBox(width: 8.w),
            Container(
              width: 9.r,
              height: 9.r,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();

    String twoDigits(int value) => value.toString().padLeft(2, '0');

    return '${twoDigits(localDate.day)}/${twoDigits(localDate.month)}/${localDate.year}'
        '  ${twoDigits(localDate.hour)}:${twoDigits(localDate.minute)}';
  }
}
