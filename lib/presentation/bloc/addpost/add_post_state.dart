part of 'add_post_bloc.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}
final class AddPostLoadingstate extends AddPostState{}
final class AddPostSuccessState extends AddPostState{}
final class AddPostErrorState extends AddPostState{}
final class AddPostErrorStateInternalServerError extends AddPostState{}
final class AddPostErrorStateDatabaseError extends AddPostState{}