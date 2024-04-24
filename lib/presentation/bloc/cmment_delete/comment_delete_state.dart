part of 'comment_delete_bloc.dart';

@immutable
sealed class CommentDeleteState {}

final class CommentDeleteInitial extends CommentDeleteState {}
final class CommentDeleteSuccessState extends CommentDeleteState{}
final class CommentDeleteInternalErrorState extends CommentDeleteState{}