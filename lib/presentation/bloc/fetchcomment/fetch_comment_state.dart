part of 'fetch_comment_bloc.dart';

@immutable
sealed class FetchCommentState {}

final class FetchCommentInitial extends FetchCommentState {}

final class FetchCommentLoadingState extends FetchCommentState {}

final class FetchCommentSuccessState extends FetchCommentState {
  final List<CommentModel> comments;

  FetchCommentSuccessState({required this.comments});
}
final class FetchCommentInternalserverErrorState extends FetchCommentState{}
final class FetchCommentErrorState extends FetchCommentState{}