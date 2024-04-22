part of 'fetch_comment_bloc.dart';

@immutable
sealed class FetchCommentEvent {}

final class FetchCommentInitialEvent extends FetchCommentEvent {
  final String postId;

  FetchCommentInitialEvent({required this.postId});
}
