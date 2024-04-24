part of 'comment_delete_bloc.dart';

@immutable
sealed class CommentDeleteEvent {}

final class CommentDeleteClickEvent extends CommentDeleteEvent {
  final String commentId;

  CommentDeleteClickEvent({required this.commentId});
}
