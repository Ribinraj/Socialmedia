part of 'fetching_user_post_bloc.dart';

@immutable
sealed class FetchingUserPostEvent {}

class FetchingUserpostInitialEvent extends FetchingUserPostEvent {
  final String userId;

  FetchingUserpostInitialEvent({required this.userId});
}
