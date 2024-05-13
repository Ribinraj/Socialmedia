part of 'get_notification_bloc.dart';

@immutable
sealed class GetNotificationState {}

final class GetNotificationInitial extends GetNotificationState {}

final class GetNotificationLoadingState extends GetNotificationState {}

final class GetNotificationSuccessState extends GetNotificationState {
  final List<NotificationModel> notifications;

  GetNotificationSuccessState({required this.notifications});
}

final class GetNotificationErrorState extends GetNotificationState {}
