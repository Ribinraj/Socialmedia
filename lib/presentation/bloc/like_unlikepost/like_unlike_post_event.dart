part of 'like_unlike_post_bloc.dart';

@immutable
sealed class LikeUnlikePostEvent {}

final class LikepostEvent extends LikeUnlikePostEvent {
  final String postid;

  LikepostEvent({required this.postid});
}

final class UnlikePostEvent extends LikeUnlikePostEvent {
  final String postid;

  UnlikePostEvent({required this.postid});
}
