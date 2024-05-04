part of 'saved_post_bloc.dart';

@immutable
sealed class SavedPostState {}

final class SavedPostInitial extends SavedPostState {}
final class SavedPostSuccessState extends SavedPostState{}
final class SavedPostInternalErrorState extends SavedPostState{}
final class UnsavedpostSuccessState extends SavedPostState{}
final class UnsavedpostInternalErrorState extends SavedPostState{}