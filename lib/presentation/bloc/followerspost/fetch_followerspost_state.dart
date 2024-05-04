part of 'fetch_followerspost_bloc.dart';

@immutable
sealed class FetchFollowerspostState {}

final class FetchFollowerspostInitial extends FetchFollowerspostState {}

final class FetchFollowersPostLoadingState extends FetchFollowerspostState {}

final class FetchFollowersPostSuccessState extends FetchFollowerspostState {
  final List<FollowerspostModel> followersposts;

  FetchFollowersPostSuccessState({required this.followersposts});
}
final class FetchFollowersPostInternalErrorstate extends FetchFollowerspostState{}
final class FetchFollowerPostErrorState extends FetchFollowerspostState{}