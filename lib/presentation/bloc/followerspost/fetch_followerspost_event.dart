part of 'fetch_followerspost_bloc.dart';

@immutable
sealed class FetchFollowerspostEvent {}

final class InitialFetchingEventFollowersPost extends FetchFollowerspostEvent {
  final int n;

  InitialFetchingEventFollowersPost({required this.n});
}
final class LoadMoreFollowersPostsEvent extends FetchFollowerspostEvent {}
