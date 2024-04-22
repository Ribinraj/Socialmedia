part of 'fetch_followerspost_bloc.dart';

@immutable
sealed class FetchFollowerspostState {}

final class FetchFollowerspostInitial extends FetchFollowerspostState {}

final class FetchFollowersLoadingState extends FetchFollowerspostState {}

final class FetchFollowersSuccessState extends FetchFollowerspostState {
  final List<FollowerspostModel> followersposts;

  FetchFollowersSuccessState({required this.followersposts});
}
final class FetchFollowersInternalErrorstate extends FetchFollowerspostState{}
final class FetchFollowersErrorState extends FetchFollowerspostState{}