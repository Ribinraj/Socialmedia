part of 'edit_post_bloc.dart';

@immutable
sealed class EditPostState {}

final class EditPostInitial extends EditPostState {}
final class EditPostLoadingState extends EditPostState{} 
final class EditPostSuccessState extends EditPostState{}
final class EditpostErrorStateInternalServerError extends EditPostState{}
final class EditpostErrorState extends EditPostState{}
