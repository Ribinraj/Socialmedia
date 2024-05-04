part of 'fetch_followings_bloc.dart';

@immutable
sealed class FetchFollowingsState {}

final class FetchFollowingsInitial extends FetchFollowingsState {}

final class FetchFollowingLoadingState extends FetchFollowingsState {}

final class FetchFollowingSuccessState extends FetchFollowingsState {
  final FollowingModel followings;

  FetchFollowingSuccessState({required this.followings});
}

final class FetchFollowingInternalErrorState extends FetchFollowingsState {}
