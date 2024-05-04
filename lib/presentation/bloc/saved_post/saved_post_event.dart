part of 'saved_post_bloc.dart';

@immutable
sealed class SavedPostEvent {}

final class SavedpostClickEvent extends SavedPostEvent {
  final String postId;

  SavedpostClickEvent({required this.postId});
}

final class UnsavedPostClickEvent extends SavedPostEvent {
  final String postId;

  UnsavedPostClickEvent({required this.postId});
}
