part of 'fetch_saved_post_bloc.dart';

@immutable
sealed class FetchSavedPostState {}

final class FetchSavedPostInitial extends FetchSavedPostState {}

final class FetchSavedpostLoadingState extends FetchSavedPostState {}

final class FetchSavedpostSuccessState extends FetchSavedPostState {
  final List<SavedpostModel> savedposts;

  FetchSavedpostSuccessState({required this.savedposts});
}
final class FetchSavedpostInternalErrorState extends FetchSavedPostState{}