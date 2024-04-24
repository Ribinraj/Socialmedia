part of 'add_comment_bloc.dart';

@immutable
sealed class AddCommentState {}

final class AddCommentInitial extends AddCommentState {}
final class AddcommentLoadingState extends AddCommentState{}
final class AddcommentSuccessState extends AddCommentState{}
final class AddcommentInternalErrorState extends AddCommentState{}