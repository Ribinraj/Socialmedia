part of 'add_comment_bloc.dart';

@immutable
sealed class AddCommentEvent {}

final class AddCommentClickEvent extends AddCommentEvent {
  final String userId;
  final String userName;
  final String postId;
  final String content;

  AddCommentClickEvent({required this.userId, required this.userName, required this.postId, required this.content});
}
