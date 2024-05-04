part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowEvent {}

final class FollowButtonClickEvent extends FollowUnfollowEvent {
  final String followeeId;

  FollowButtonClickEvent({required this.followeeId});
}

final class UnFollowButtonClickEvent extends FollowUnfollowEvent {
  final String unfolloweeId;

  UnFollowButtonClickEvent({required this.unfolloweeId});
}

final class IsfollowingInitialEvent extends FollowUnfollowEvent {
  final String userId;

  IsfollowingInitialEvent({required this.userId});
}
