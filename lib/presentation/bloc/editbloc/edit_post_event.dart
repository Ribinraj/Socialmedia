part of 'edit_post_bloc.dart';

@immutable
sealed class EditPostEvent {}

final class EditPostClickevent extends EditPostEvent {
  final String imageurl;
  final String description;
  final String postid;

  EditPostClickevent(
      {required this.imageurl,
      required this.description,
      required this.postid});
}
