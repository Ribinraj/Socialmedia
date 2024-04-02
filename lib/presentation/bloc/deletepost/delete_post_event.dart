part of 'delete_post_bloc.dart';

@immutable
sealed class DeletePostEvent {}

final class DeletepostClickEvent extends DeletePostEvent {
  final String postid;

  DeletepostClickEvent({required this.postid});
}
