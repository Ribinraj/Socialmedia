part of 'fetching_user_post_bloc.dart';

@immutable
sealed class FetchingUserPostState {}

final class FetchingUserPostInitial extends FetchingUserPostState {}

final class FetchUserPostLoadingState extends FetchingUserPostState {}

final class FetchUserPostSuccessState extends FetchingUserPostState {
  final List<Postmodel> userposts;

  FetchUserPostSuccessState({required this.userposts});
}
final class FetchUserPostsErrorInternalErrorState extends FetchingUserPostState{}
final class FetchUserPostsErrorUsernoteFoundErrorState extends FetchingUserPostState{}
final class FetchUserPostsErrorState extends FetchingUserPostState{}