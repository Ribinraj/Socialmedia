part of 'follow_unfollow_bloc.dart';

@immutable
sealed class FollowUnfollowState {}

final class FollowUnfollowInitial extends FollowUnfollowState {}

final class FollowuserSuccessState extends FollowUnfollowState {}

final class FollowuserInternalErrorState extends FollowUnfollowState {}

final class UnfollowuserSuccessState extends FollowUnfollowState {}

final class UnfollowuserInternalErrorState extends FollowUnfollowState {}

final class IsfollowingSuccessState extends FollowUnfollowState {
  final bool isfollowing;

  IsfollowingSuccessState({required this.isfollowing});
}

final class IsfollowInternalErrorState extends FollowUnfollowState {}
